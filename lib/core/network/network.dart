import 'dart:io';

import 'package:dio/dio.dart';
import 'package:amnak/core/error/exceptions.dart';
import 'package:amnak/features/auth/presentation/cubit.dart';

import '../../export.dart';

const url = 'https://api.amnak.app/api/';

class Network {
  final Dio dio;
  final LocalDataSource box;
  Network({
    required this.dio,
    required this.box,
  });

  late Map<String, String?> headers;

  Future<Response> req(Future<Response> Function() requestType) async {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'locale':
          (await box.containsKey(kLanguage) ? await box.read(kLanguage) : 'ar'),
    };
    if (await box.containsKey(kToken)) {
      headers = {
        ...headers,
        'Authorization': 'Bearer ${await box.read(kToken)}',
        'X-Auth-Type':
            '${(await box.read(kUser) as Map<String, dynamic>)['type_account']}',
      };
    }
    try {
      final response = await requestType();
      if (response.statusCode! > 210 || response.statusCode! < 200) {
        // Logger().i(response.data);
        throw response.data;
      }
      if (response.data['status'] == 401 &&
          navKey.currentContext?.routeName != Routes.login) {
        sl<AuthCubit>().logout();
        throw response.data;
      }
      if (response.data['status'] != 200 && response.data['status'] != 204) {
        throw response.data;
      }
      // success
      return response;
    } on DioException catch (e) {
      // Logger().i(e.message);
      throw ServerException(message: e.message.toString());
    } catch (e) {
      // Logger().i(e);
      throw ServerException(message: e.toString());
    }
  }

  String _getParamsFromBody(dynamic body) {
    String params = '';
    for (var i = 0; i < body?.keys.length; i++) {
      params += '${List.from(body?.keys)[i]}=${List.from(body?.values)[i]}';
      if (i != body!.keys.length - 1) {
        params += '&';
      }
    }
    return params;
  }

  Future<Response> post(String endPoint, dynamic body,
      {bool isParamData = false, String? baseUrl}) async {
    return req(() {
      return dio.post(
          (baseUrl ?? url) +
              endPoint +
              (isParamData ? _getParamsFromBody(body) : ''),
          data: isParamData ? {} : body,
          options: Options(headers: headers));
    });
  }

  Future<Response> put(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.put(url + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> delete(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.delete(url + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<Response> get(String endPoint, dynamic body, {String? baseUrl}) {
    return req(() {
      return dio.get((baseUrl ?? url) + endPoint,
          options: Options(headers: headers));
    });
  }

  Future<Response> uploadImage(
    String endPoint,
    Map<String, dynamic>? user,
    File? file,
  ) async {
    FormData formData;
    String? fileName = file?.path.split('/').last;
    formData = FormData.fromMap(fileName == null
        ? {...?user}
        : {
            ...?user,
            'profile_image': [
              await MultipartFile.fromFile(file!.path, filename: fileName)
            ],
          });
    Logger().i(formData.fields);
    return req(() {
      return dio.post(url + endPoint,
          data: formData, options: Options(headers: headers));
    });
  }

  downloadFileFromUrl(String url, String savePath) async {
    await dio.download(url, savePath, onReceiveProgress: (received, total) {});
    print("File is saved to download folder.");
  }
}
