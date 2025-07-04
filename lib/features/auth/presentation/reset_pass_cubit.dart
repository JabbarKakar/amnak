import 'package:amnak/features/auth/domain/usecases/usecases.dart';

import '../../../../../export.dart';

class ResetPassCubit extends Cubit<BaseState> {
  ResetPassCubit({
    required this.useCase,
  }) : super(const BaseState());
  final UserUseCase useCase;

  Future sendCode(String phone) async {
    return await handleError(() async {
      // final response = await useCase.resetPasswordCode(phone);
      // return response.fold((l) {
      //   showWarningDialog(text: l.message.toString());
      // }, (r) {
      //   showSimpleDialog(text: r?['data']?['message']?.toString() ?? '');
      //   return r['data'];
      // });
    });
  }

  Future resetPass(Map<String, dynamic> data) async {
    return await handleError(() async {
      // final response = await useCase.resetPassword(data);
      // return response.fold((l) {
      //   showWarningDialog(text: l.message.toString());
      // }, (r) {
      //   showSimpleDialog(text: r?['data']?['message']?.toString() ?? '');
      //   return r;
      // });
    });
  }
}
