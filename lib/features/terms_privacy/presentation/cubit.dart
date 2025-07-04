import 'package:amnak/features/terms_privacy/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class TermsCubit extends Cubit<BaseState<String>> {
  TermsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final TermsUseCase useCase;

  Future get(String type) async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.get(type);

    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        emit(state.copyWith(status: RxStatus.success, data: r.data['value']));
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.message.toString()));
      return r;
    });
  }
}
