import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:microblogging/database/database-helper.dart';
import 'package:microblogging/models/posts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsEditBloc extends BlocBase {
  final _dataController = BehaviorSubject<Posts>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<Posts> get outData => _dataController.stream;

  Stream<bool> get outLoading => _loadingController.stream;
  Posts posts;

  PostsEditBloc({this.posts}) {
    _dataController.add(posts);
  }

  void saveContent(String value) {
    posts.content = value;
  }

  Future<bool> save() async {
    int ret = 0;
    _loadingController.add(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (posts.id != null) {
      ret = await DatabaseHelper.instance.update(
        "posts",
        {
          "content": posts.content,
          "name": preferences.getString('name'),
          "created_at": DateTime.now().toString(),
        },
        "id = ? ",
        [posts.id],
      );
    } else {
      ret = await DatabaseHelper.instance.insert(
        "posts",
        {
          "content": posts.content,
          "name": preferences.getString('name'),
          "created_at": DateTime.now().toString(),
        },
      );
    }
    _loadingController.add(false);
    return ret >= 1;
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    super.dispose();
  }
}
