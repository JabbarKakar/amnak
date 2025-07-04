import 'package:amnak/core/feature/data/models/courses_wrapper.dart';
import 'package:amnak/features/courses/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class CoursesCubit extends Cubit<BaseState<CoursesWrapper>> {
  CoursesCubit({
    required this.useCase,
  }) : super(const BaseState());
  final CoursesUseCase useCase;

  Future get() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.get();

    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        if (r.data!.isEmpty) {
          emit(state.copyWith(status: RxStatus.empty));
        } else
          emit(state.copyWith(status: RxStatus.success, data: r));
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.messages.toString()));
      return r;
    });
  }
}
