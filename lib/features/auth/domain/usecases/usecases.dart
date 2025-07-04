import 'dart:io';

import 'package:dio/dio.dart';
import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/feature/data/models/user_wrapper.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class UserUseCase {
  final Repository repository;

  UserUseCase({required this.repository});

  Future<Either<Failure, LoginWrapper>> login(Map user) async {
    return (repository.post('login', user)).then((value) => value
        .map((r) => r == null ? LoginWrapper() : LoginWrapper.fromJson(r)));
  }

  Future<Either<Failure, LoginWrapper>> signup(FormData user) async {
    return (repository.postForm('register', user)).then((value) => value
        .map((r) => r == null ? LoginWrapper() : LoginWrapper.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> deleteAccount() async {
    return repository.update('person_delete_account', {}).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> changePass(Map user) async {
    return (repository.post('reset_password', user)).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> sendCode(Map user) async {
    return (repository.post('forget_password', user)).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }

  Future<Either<Failure, UserWrapper>> getUser() async {
    return (repository.get('person_profile')).then((value) =>
        value.map((r) => r == null ? UserWrapper() : UserWrapper.fromJson(r)));
  }

  Future<Either<Failure, UserWrapper>> uploadProfileImage(
      File? image, Map user) async {
    return (repository.uploadImage('person_profile', user, image)).then(
        (value) => value
            .map((r) => r == null ? UserWrapper() : UserWrapper.fromJson(r)));
  }
}
