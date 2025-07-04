import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/features/auth/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class UpdatePassCubit extends Cubit<BaseState<UserModel>> {
  UpdatePassCubit({
    required this.useCase,
  }) : super(const BaseState());
  final UserUseCase useCase;

  Future sendCode(Map<String, dynamic> data, BuildContext context) async {
    return await handleError(() async {
      final response = await useCase.sendCode(data);
      return response.fold((l) {
        showSimpleDialog(text: l.message.toString());
        return null;
      }, (r) {
        Logger().i(r);
        showSimpleDialog(text: r.message.toString());
        context.pushNamed(Routes.updatePass, extra: data['email']);
        return r;
      });
    });
  }

  Future changePass(Map<String, dynamic> data, BuildContext context) async {
    return await handleError(() async {
      final response = await useCase.changePass(data);
      return response.fold((l) {
        showSimpleDialog(text: l.message.toString());
        return null;
      }, (r) {
        Logger().i(r);
        showSimpleDialog(text: r.message.toString());
        context.go(Routes.login);
        return r;
      });
    });
  }
}
