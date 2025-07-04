import 'package:amnak/core/feature/data/models/user_wrapper.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class BooksUseCase {
  final Repository repository;

  BooksUseCase({required this.repository});

  Future<Either<Failure, UserWrapper>> get(int pageNum) async {
    return (repository.get('/Book?pageNumber=$pageNum')).then((value) =>
        value.map((r) => r == null ? UserWrapper() : UserWrapper.fromJson(r)));
  }
}
