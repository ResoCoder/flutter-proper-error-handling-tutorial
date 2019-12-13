import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'post_service.dart';

enum NotifierState { initial, loading, loaded }

class PostChangeNotifier extends ChangeNotifier {
  final _postService = PostService();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  Either<Failure, Post> _post;
  Either<Failure, Post> get post => _post;
  void _setPost(Either<Failure, Post> post) {
    _post = post;
    notifyListeners();
  }

  void getOnePost() async {
    _setState(NotifierState.loading);
    await Task(() => _postService.getOnePost())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) => _setPost(value));
    _setState(NotifierState.loaded);
  }
}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return this.map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}
