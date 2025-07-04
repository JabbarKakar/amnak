import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class TermsUseCase {
  final Repository repository;

  TermsUseCase({required this.repository});

  Future<Either<Failure, ServerResponse>> get(String type) async {
    return (repository.get('page/$type')).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
    // return Future.value(Right(TermsWrapper.fromJson({
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
