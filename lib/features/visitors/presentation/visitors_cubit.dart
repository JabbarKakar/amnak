import 'package:amnak/core/feature/data/models/visitors_wrapper.dart';
import 'package:amnak/features/visitors/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class VisitorsCubit extends Cubit<BaseState<VisitorsWrapper>> {
  VisitorsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final VisitorsUseCase useCase;

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
            status: RxStatus.error, errorMessage: r.message.toString()));
      return r;
    });
  }
}
