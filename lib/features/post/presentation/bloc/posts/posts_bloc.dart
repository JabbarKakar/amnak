import 'package:bloc/bloc.dart';
import 'package:amnak/core/utils/utils.dart';
import 'package:amnak/features/post/domain/usecases/post.dart';
import '../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostUsecases postUseCases;
  PostsBloc({
    required this.postUseCases,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await postUseCases.getAll();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        await handleRequest(() async {
          emit(LoadingPostsState());
          final failureOrPosts = await postUseCases.getAll();
          emit(_mapFailureOrPostsToState(failureOrPosts));
        });
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'SERVER_FAILURE_MESSAGE';
      case EmptyCacheFailure:
        return 'EMPTY_CACHE_FAILURE_MESSAGE';
      case OfflineFailure:
        return 'OFFLINE_FAILURE_MESSAGE';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
