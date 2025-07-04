import 'package:amnak/core/feature/data/models/projects_wrapper.dart';
import 'package:amnak/core/feature/data/models/report_types.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class ProjectsUseCase {
  final Repository repository;

  ProjectsUseCase({required this.repository});

  Future<Either<Failure, ProjectsWrapper>> get({int pageNum = 1}) async {
    return (repository.get('employee_projects')).then((value) => value.map(
        (r) => r == null ? ProjectsWrapper() : ProjectsWrapper.fromJson(r)));
  }

  Future<Either<Failure, ReportTypesWrapper>> getReportTypes(
      {int pageNum = 1}) async {
    return (repository.get('report_types')).then((value) => value.map((r) =>
        r == null ? ReportTypesWrapper() : ReportTypesWrapper.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> getAmbulancePhone() async {
    return (repository.get('ambulance_phone')).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> addReport(Map data) async {
    return (repository.post('make_report', data)).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> attend(Map data) async {
    return (repository.post('employee_attendance', data)).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }
}
