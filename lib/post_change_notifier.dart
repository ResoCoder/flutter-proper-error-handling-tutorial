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

  Post _post;
  Post get post => _post;
  void _setPost(Post post) {
    _post = post;
    notifyListeners();
  }

  Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  void getOnePost() async {
    _setState(NotifierState.loading);
    try {
      final post = await _postService.getOnePost();
      _setPost(post);
    } on Failure catch (f) {
      _setFailure(f);
    }
    _setState(NotifierState.loaded);
  }
}
