import 'package:amnak/core/feature/data/models/projects_wrapper.dart';
import 'package:amnak/features/projects/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class HomeCubit extends Cubit<BaseState<ProjectsWrapper>> {
  HomeCubit({
    required this.useCase,
  }) : super(const BaseState());
  final ProjectsUseCase useCase;

  Future get() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.get();

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

  Future attend(Map data) async {
    final response = await useCase.attend(data);
    return response.fold((l) {
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      Logger().i(r.data);
      showSuccessSnack(message: navKey.currentContext!.t.success);
      return r;
    });
  }
}
