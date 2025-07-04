import 'package:amnak/export.dart';

import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const CACHED_POSTS = "CACHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final GetStorage sharedPreferences;
  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    sharedPreferences.write(CACHED_POSTS, postModels);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.read(CACHED_POSTS);
    if (jsonString != null) {
      return postsToJson(jsonString);
    } else {
      throw EmptyCacheException();
    }
  }
}
