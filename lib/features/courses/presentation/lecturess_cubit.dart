import 'package:amnak/core/feature/data/models/lectures_wrapper.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/courses/domain/usecases/usecases.dart';

class LecturesCubit extends Cubit<BaseState<LecturesWrapper>> {
  LecturesCubit({
    required this.useCase,
  }) : super(const BaseState());
  final CoursesUseCase useCase;

  Future get(String courseId) async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getLectures(courseId);

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
