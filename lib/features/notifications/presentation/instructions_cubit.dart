import 'package:amnak/core/feature/data/models/instructions_wrapper.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/notifications/domain/usecases/usecases.dart';

class InstructionsCubit extends Cubit<BaseState<InstructionsWrapper>> {
  InstructionsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final NotificationsUseCase useCase;

  Future get() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getInstructions();

    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        emit(state.copyWith(status: RxStatus.success, data: r));
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.messages.toString()));
      return r;
    });
  }
}
