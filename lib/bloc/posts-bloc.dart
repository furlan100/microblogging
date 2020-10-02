import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:microblogging/database/database-helper.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc extends BlocBase {
  final _postsController = BehaviorSubject<List<Map<String, dynamic>>>();

  Stream<List<Map<String, dynamic>>> get outPosts => _postsController.stream;
  List<Map<String, dynamic>> _posts = [];

  PostsBloc() {
    _addPostsListener();
  }

  void _addPostsListener() async {
    String sql = "SELECT * FROM posts ";
    this._posts = await DatabaseHelper.instance.query(sql, []);
    _postsController.add(_posts.toList());
  }

  @override
  void dispose() {
    _postsController.close();
    super.dispose();
  }
}
