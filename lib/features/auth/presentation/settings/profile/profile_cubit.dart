import 'dart:io';

import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/feature/data/models/user_wrapper.dart';
import 'package:amnak/features/auth/domain/usecases/usecases.dart';

import '../../../../../../export.dart';

class ProfileCubit extends Cubit<BaseState<UserModel>> {
  ProfileCubit({
    required this.useCase,
    required this.box,
  }) : super(const BaseState());
  final UserUseCase useCase;
  final GetStorage box;
  Future get() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getUser();
    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      onUserResult(r);
      return r;
    });
  }

  void onUserResult(UserWrapper r) {
    if (r.data != null) {
      emit(state.copyWith(status: RxStatus.success, data: r.data));
      sl<GetStorage>().write(kUser, r.data?.toJson());
    } else
      emit(state.copyWith(
          status: RxStatus.error, errorMessage: r.message.toString()));
  }

  Future uploadProfileImage(File? image, Map<String, dynamic> user) async {
    // return await handleRequest(() async {
    final response = await useCase.uploadProfileImage(image, user);
    return response.fold((l) async {
      await showSimpleDialog(text: l.message.toString());
      return null;
    }, (r) {
      Logger().i(r);
      sl<GetStorage>().write(kUser, r.data?.toJson());
      emit(state.copyWith(status: RxStatus.success, data: r.data));
      return r;
    });
    // });
  }

  logout() async {
    return await handleError(() async {
      box.erase();
    });
  }
}
