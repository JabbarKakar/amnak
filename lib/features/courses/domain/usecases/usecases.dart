import 'package:amnak/core/feature/data/models/lectures_wrapper.dart';
import 'package:amnak/core/feature/data/models/courses_wrapper.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class CoursesUseCase {
  final Repository repository;

  CoursesUseCase({required this.repository});

  Future<Either<Failure, CoursesWrapper>> get() async {
    return (repository.get('courses')).then((value) => value
        .map((r) => r == null ? CoursesWrapper() : CoursesWrapper.fromJson(r)));
  }

  Future<Either<Failure, LecturesWrapper>> getLectures(String courseId) async {
    return (repository.get('course/$courseId/lectures')).then((value) =>
        value.map((r) =>
            r == null ? LecturesWrapper() : LecturesWrapper.fromJson(r)));
  }
}
