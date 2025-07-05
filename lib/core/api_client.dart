import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../export.dart';
import '../features/auth/presentation/cubit.dart';
import 'network/network.dart';

class APIClient {
  Dio _dio = Dio();
  final LocalDataSource box;

  APIClient({required this.box}) {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: const Duration(seconds: 40),
      connectTimeout: const Duration(seconds: 40),
      baseUrl: url,
      maxRedirects: 2,
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      error: true,
      request: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  Future<Map<String, dynamic>> getHeaders() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'locale': (await box.containsKey('language') ? await box.read('language') : 'ar'),
    };

    if (await box.containsKey('token')) {
      // final user = await box.read('user') as Map<String, dynamic>?;
      headers.addAll({
        'Authorization': 'Bearer ${await box.read(kToken)}',
        'X-Auth-Type': '${(await box.read(kUser) as Map<String, dynamic>)['type_account']}',
      });
    }
    return headers;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final headers = await getHeaders();
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(responseType: ResponseType.json, headers: headers),
      );
      print("Api url ------> $url");
      return _handleResponse(response);
    } on DioException catch (exception) {
      NetworkHandler.handleDioError(exception);
      throw ServerException(message: exception.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> post({
    required String url,
    dynamic params,
    bool isParamData = false,
  }) async {
    try {
      final headers = await getHeaders();
      final response = await _dio.post(
        isParamData ? '$url${_getParamsFromBody(params)}' : url,
        data: isParamData ? {} : params,
        options: Options(responseType: ResponseType.json, headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (exception) {
      NetworkHandler.handleDioError(exception);
      throw ServerException(message: exception.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> delete({
    required String url,
    dynamic params,
  }) async {
    try {
      final headers = await getHeaders();
      final response = await _dio.delete(
        url,
        data: params,
        options: Options(responseType: ResponseType.json, headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (exception) {
      NetworkHandler.handleDioError(exception);
      throw ServerException(message: exception.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> put({
    required String url,
    dynamic params,
  }) async {
    try {
      final headers = await getHeaders();
      final response = await _dio.put(
        url,
        data: params,
        options: Options(responseType: ResponseType.json, headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (exception) {
      NetworkHandler.handleDioError(exception);
      throw ServerException(message: exception.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Response> uploadImage({
    required String url,
    Map<String, dynamic>? user,
    File? file,
  }) async {
    try {
      final headers = await getHeaders();
      String? fileName = file?.path.split('/').last;
      final formData = FormData.fromMap(fileName == null
          ? {...?user}
          : {
        ...?user,
        'profile_image': [
          await MultipartFile.fromFile(file!.path, filename: fileName)
        ],
      });
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (exception) {
      NetworkHandler.handleDioError(exception);
      throw ServerException(message: exception.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> downloadFileFromUrl(String url, String savePath) async {
    try {
      final headers = await getHeaders();
      await _dio.download(url, savePath, options: Options(headers: headers));
      print("File is saved to download folder.");
    } on DioException catch (exception) {
      NetworkHandler.handleDioError(exception);
      throw ServerException(message: exception.message.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  String _getParamsFromBody(dynamic body) {
    if (body == null) return '';
    String params = '';
    for (var i = 0; i < body.keys.length; i++) {
      params += '${List.from(body.keys)[i]}=${List.from(body.values)[i]}';
      if (i != body.keys.length - 1) {
        params += '&';
      }
    }
    return params.isNotEmpty ? '?$params' : '';
  }

  Response _handleResponse(Response response) {
    if (response.statusCode! < 200 || response.statusCode! > 210) {
      throw ServerException(message: response.data.toString());
    }
    if (response.data['status'] == 401) {
      // Assuming navKey and Routes are accessible globally or via dependency injection
      if (navKey.currentContext!.routeName != 'login') {
        sl<AuthCubit>().logout();
      }
      throw ServerException(message: response.data.toString());
    }
    if (response.data['status'] != 200 && response.data['status'] != 204) {
      throw ServerException(message: response.data.toString());
    }
    return response;
  }
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}


class NetworkHandler {
  static NetworkError handleDioError(DioException error) {
    String message = '';
    NetworkErrorType errorType = NetworkErrorType.unknown;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout. Please try again later.";
        errorType = NetworkErrorType.connectionTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout. Please try again later.";
        errorType = NetworkErrorType.receiveTimeout;
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout. Please try again later.";
        errorType = NetworkErrorType.sendTimeout;
        break;
      case DioExceptionType.cancel:
        message = "Request to the server was cancelled.";
        errorType = NetworkErrorType.cancelled;
        break;
      case DioExceptionType.connectionError:
        message = "Connection error occurred. Please check your internet connection.";
        errorType = NetworkErrorType.connectionError;
        break;
      case DioExceptionType.badResponse:
        if (error.response != null) {
          Map<String, dynamic> map = error.response!.data;
          message = map['error'] ?? map['message'] ?? "An unexpected error occurred. Please try again.";
          errorType = NetworkErrorType.badResponse;
        } else {
          message = "An unexpected error occurred. Please try again.";
          errorType = NetworkErrorType.unknown;
        }
        break;
      default:
        message = "An unexpected error occurred. Please try again.";
        errorType = NetworkErrorType.unknown;
        break;
    }

    Fluttertoast.showToast(
      msg: error.message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // AppConstants.flutterToast(message: message, title: 'Error');
    print("DioError in network error handler class =====> $message");
    print("DioError in network error handler class =====> ${error.message}");

    return NetworkError(message: message, type: errorType);
  }
}

enum NetworkErrorType {
  connectionTimeout,
  receiveTimeout,
  sendTimeout,
  cancelled,
  connectionError,
  badResponse,
  unknown
}

class NetworkError {
  final String message;
  final NetworkErrorType type;

  NetworkError({
    required this.message,
    required this.type,
  });
}