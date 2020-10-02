import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:microblogging/database/database-helper.dart';
import 'package:microblogging/models/user.dart';
import 'package:rxdart/rxdart.dart';

class UserEditBloc extends BlocBase {
  final _dataController = BehaviorSubject<User>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<User> get outData => _dataController.stream;

  Stream<bool> get outLoading => _loadingController.stream;
  User user;

  UserEditBloc({this.user}) {
    _dataController.add(user);
  }

  void saveName(String value) {
    user.name = value;
  }

  void savePassword(String value) {
    user.password = value;
  }

  void saveUser(String value) {
    user.user = value;
  }

  Future<bool> save() async {
    int ret = 0;
    _loadingController.add(true);

    if (user.id != null) {
      ret = await DatabaseHelper.instance.update(
        "user",
        {
          "user": user.user,
          "name": user.name,
          "password": user.password,
        },
        "id = ? ",
        [user.id],
      );
    } else {
      ret = await DatabaseHelper.instance.insert(
        "user",
        {
          "user": user.user,
          "name": user.name,
          "password": user.password,
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
