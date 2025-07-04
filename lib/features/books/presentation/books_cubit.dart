import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/feature/data/models/user_wrapper.dart';
import 'package:amnak/features/auth/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class BooksCubit extends Cubit<BaseState<UserModel>> {
  BooksCubit({
    required this.useCase,
  }) : super(const BaseState());
  final UserUseCase useCase;

  Future get() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getUser();
    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        emit(state.copyWith(status: RxStatus.success, data: r.data));
        sl<GetStorage>().write(kUser, r.data?.toJson());
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.message.toString()));
      return r;
    });
  }
}
