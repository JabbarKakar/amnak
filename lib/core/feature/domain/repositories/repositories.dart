import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../export.dart';

abstract class Repository {
  Future<Either<Failure, Map<String, dynamic>?>> get(String endPoint,
      {Map? data, String? cacheName});
  Future<Either<Failure, Map<String, dynamic>?>> post(
      String endPoint, Map? data);
  Future<Either<Failure, Map<String, dynamic>?>> postForm(
      String endPoint, FormData? data);
  Future<Either<Failure, Map<String, dynamic>?>> uploadImage(
      String endPoint, Map? data, File? file);
  Future<Either<Failure, Map<String, dynamic>?>> update(
      String endPoint, Map? data);
  Future<Either<Failure, Map<String, dynamic>?>> delete(
      String endPoint, Map? data);

  dynamic readFromLocalDB(String key);
  Future<void> writeToLocalDB(String key, Map<String, dynamic> value);
}
