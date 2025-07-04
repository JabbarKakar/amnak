import 'package:dio/dio.dart';
import 'package:amnak/features/auth/domain/usecases/usecases.dart';

import '../../../../../export.dart';

class AuthCubit extends Cubit<BaseState> {
  AuthCubit({
    required this.useCase,
    required this.box,
  }) : super(const BaseState());
  final UserUseCase useCase;
  final GetStorage box;

  Future login(Map<String, String> user) async {
    return await handleError(() async {
      final response = await useCase.login(user);
      return response.fold((l) {
        Logger().e(l);
        showSimpleDialog(text: l.message.toString());
        return null;
      }, (r) {
        if (r.data?.token != null) {
          box.write(kToken, r.data!.token);
          box.write(kUser, r.data!.toJson());
          return r;
        } else {
          showFailSnack(message: r.toString());
        }
      });
    });
  }

  Future signup(FormData user) async {
    return await handleError(() async {
      final response = await useCase.signup(user);
      return response.fold((l) {
        Logger().e(l);
        debugPrint("This is the error: ${l.message}");
        showSimpleDialog(text: l.message.toString());
        return null;
      }, (r) {
        Logger().i(r.toJson());
        if (r.data?.token != null) {
          box.write(kToken, r.data!.token);
          box.write(kUser, r.data!.toJson());
          return r;
        }
        if (r.data != null) {
          return r;
        }
      });
    });
  }

  Future deleteAccount() async {
    return await handleError(() async {
      final response = await useCase.deleteAccount();
      return response.fold((l) {
        showSimpleDialog(text: l.message.toString());
        return null;
      }, (r) async {
        Logger().i(r);
        await logout();
        return r;
      });
    });
  }

  Future logout() async {
    await box.remove(kUser);
    await box.remove(kToken);
    await box.remove(kRefreshToken);
    AppRouter.routes.goNamed(Routes.landing);
  }
}
