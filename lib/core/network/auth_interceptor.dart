import 'dart:async';

import 'package:dio/dio.dart';

import 'package:amnak/core/network/network.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/auth/presentation/cubit.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final AuthCubit authCubit;
  final GetStorage box;
  bool isRefreshing = false;
  Completer<String?>? _refreshCompleter;
  final List<Completer<Response>> _requestQueue = [];

  AuthInterceptor({
    required this.dio,
    required this.authCubit,
    required this.box,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    Logger().i('auth Interceptor ${err.requestOptions.uri.path}');
    if (!err.requestOptions.uri.path.contains('login')) {
      if (err.response?.statusCode == 401) {
        if (isRefreshing) {
          final completer = Completer<Response>();
          _requestQueue.add(completer);
          return completer.future.then((response) {
            handler.resolve(response);
          }).catchError((error) {
            handler.reject(error);
          });
        }

        isRefreshing = true;

        try {
          final newToken = await refreshToken();

          if (newToken != null) {
            final retriedResponse =
                await _retryRequest(err.requestOptions, newToken);
            handler.resolve(retriedResponse);

            // Retry queued requests
            for (final completer in _requestQueue) {
              completer
                  .complete(await _retryRequest(err.requestOptions, newToken));
            }
          } else {
            authCubit.logout();
            handler.reject(err); // Reject original request
          }
        } catch (e) {
          handler.reject(err);
          for (final completer in _requestQueue) {
            completer.completeError(e);
          }
        } finally {
          _requestQueue.clear();
          isRefreshing = false;
        }
      } else {
        Logger().i(err.response?.data);
        super.onError(err.copyWith(message: err.response?.data.toString()),
            handler); // Pass other errors
      }
    } else {
      Logger().i(err.response?.data);
      super.onError(
          err.copyWith(message: err.response?.data.toString()), handler);
    }
  }

  Future<Response> _retryRequest(
      RequestOptions request, String newToken) async {
    request.headers['Authorization'] = 'Bearer $newToken';
    return dio.fetch(request);
  }

  Future<String?> refreshToken() async {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer();

    try {
      var headers = {
        'X-Api-Key': '627F5B4F4C6C7297F54D71A31131C',
        'Content-Type': 'application/json',
        'Accept-Language':
            (box.hasData(kLanguage) ? await box.read(kLanguage) : 'ar'),
      };
      final response = await dio.post(
        '${url}auth/refresh',
        data: {'refreshToken': await box.read(kRefreshToken)},
        options: Options(headers: headers),
      );

      final newToken = response.data['data']['token'];
      Logger().i('refreshToken newToken $newToken');
      await box.write(kToken, newToken);
      await box.write(kRefreshToken, response.data['data']['refreshToken']);

      _refreshCompleter!.complete(newToken);
      return newToken;
    } catch (e) {
      _refreshCompleter!.completeError(e);
      authCubit.logout();
      return null;
    } finally {
      _refreshCompleter = null;
    }
  }
}
