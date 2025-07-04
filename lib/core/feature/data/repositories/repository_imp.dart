import 'dart:io';

import 'package:dio/dio.dart';
import 'package:amnak/export.dart';

import '../../domain/repositories/repositories.dart';

class RepoImp implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  RepoImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>?>> get(String endPoint,
      {Map? data, String? cacheName}) async {
    final res = await remoteDataSource.get(endPoint, data);
    return res.fold(
      (failure) async {
        if (failure is OfflineFailure && cacheName != null) {
          if (await localDataSource.containsKey(cacheName)) {
            final cachedData = await localDataSource.read(cacheName);
            return Right(cachedData);
          }
          return left(const EmptyCacheFailure(message: 'no_data'));
        }
        return left(failure);
      },
      (serverResponse) {
        if (cacheName != null && serverResponse.data != null) {
          localDataSource.write(cacheName, serverResponse.toJson());
        }
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> post(
      String endPoint, Map? data) async {
    final res = await remoteDataSource.post(endPoint, data);
    return res.fold(
      (failure) {
        return left(failure);
      },
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> postForm(
      String endPoint, FormData? data) async {
    final res = await remoteDataSource.post(endPoint, data);
    return res.fold(
      (failure) {
        return left(failure);
      },
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> uploadImage(
      String endPoint, Map? data, File? file) async {
    final res = await remoteDataSource.uploadImage(endPoint, data, file);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> update(
      String endPoint, Map? data) async {
    final res = await remoteDataSource.patch(endPoint, data);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> delete(
      String endPoint, Map? data) async {
    final res = await remoteDataSource.delete(endPoint, data);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  dynamic readFromLocalDB(String key) => localDataSource.read(key);

  @override
  Future<void> writeToLocalDB(String key, Map<String, dynamic> value) async =>
      await localDataSource.write(key, value);
}
