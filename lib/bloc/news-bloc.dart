import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:microblogging/database/database-helper.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc extends BlocBase {
  final _newsController = BehaviorSubject<List<Map<String, dynamic>>>();

  Stream<List<Map<String, dynamic>>> get outNews => _newsController.stream;

  List<Map<String, dynamic>> _news = [];

  NewsBloc() {
    _addNewsListener();
  }

  void _addNewsListener() async {
    String sql = "SELECT * FROM news ";
    this._news = await DatabaseHelper.instance.query(sql, []);
    _newsController.add(_news.toList());
  }

  @override
  void dispose() {
    _newsController.close();
    super.dispose();
  }
}
