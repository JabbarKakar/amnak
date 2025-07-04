import 'package:amnak/core/feature/data/models/visitors_wrapper.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class VisitorsUseCase {
  final Repository repository;

  VisitorsUseCase({required this.repository});

  Future<Either<Failure, VisitorsWrapper>> get({int pageNum = 1}) async {
    return (repository.get('visit_requests')).then((value) => value.map(
        (r) => r == null ? VisitorsWrapper() : VisitorsWrapper.fromJson(r)));
    // return Future.value(Right(VisitorsWrapper.fromJson({
    //   "success": true,
    //   "message": "Success",
    //   "data": [
    //     for (int i = 0; i < 15; i++)
    //       VisitorModel(
    //         bookID: i,
    //         name: "visitor $i",
    //         image: "https://via.placeholder.com/150",
    //         jobTitle: i % 2 == 0 ? "visitor Manager" : "Human Resource",
    //       ).toJson(),
    //   ]
    // })));
  }
}
