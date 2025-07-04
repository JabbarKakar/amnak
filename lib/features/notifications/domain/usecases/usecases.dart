import 'package:amnak/core/feature/data/models/instructions_wrapper.dart';
import 'package:amnak/core/feature/data/models/notifications_wrapper.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class NotificationsUseCase {
  final Repository repository;

  NotificationsUseCase({required this.repository});

  Future<Either<Failure, NotificationsWrapper>> get({int pageNum = 1}) async {
    return (repository.get('notifications?status=all')).then((value) =>
        value.map((r) => r == null
            ? NotificationsWrapper()
            : NotificationsWrapper.fromJson(r)));
  }

  Future<Either<Failure, InstructionsWrapper>> getInstructions(
      {int pageNum = 1}) async {
    return (repository.get('company_instructions')).then((value) => value.map(
        (r) => r == null
            ? InstructionsWrapper()
            : InstructionsWrapper.fromJson(r)));
  }
}
