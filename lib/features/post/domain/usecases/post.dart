import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class PostUsecases {
  final PostsRepository repository;

  PostUsecases(this.repository);

  Future<Either<Failure, List<Post>>> getAll() async {
    return await repository.getAllPosts();
  }

  Future<Either<Failure, Unit>> addPost(Post post) async {
    return await repository.addPost(post);
  }

  Future<Either<Failure, Unit>> updatePost(Post post) async {
    return await repository.updatePost(post);
  }

  Future<Either<Failure, Unit>> deletePost(num postId) async {
    return await repository.deletePost(postId.toInt());
  }
}
