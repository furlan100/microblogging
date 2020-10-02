import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:microblogging/database/database-helper.dart';
import 'package:microblogging/models/news.dart';
import 'package:microblogging/models/user.dart';
import 'package:microblogging/validators/login-validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL, FAILLOGIN }

class LoginBloc extends BlocBase with LoginValidators {
  final BaseOptions options = new BaseOptions(connectTimeout: 0);
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);

  Stream<String> get outPassword => _senhaController.stream.transform(validatePassword);

  Stream<LoginState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Rx.combineLatest2(
        outEmail,
        outPassword,
        ((a, b) {
          return true;
        }),
      );

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _senhaController.sink.add;

  LoginBloc() {
    _stateController.add(LoginState.IDLE);
  }

  void submit() async {
    try {
      _stateController.add(LoginState.LOADING);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      DatabaseHelper db = DatabaseHelper.instance;
      List<Map<String, dynamic>> result = await db.getAll("config");

      if (result.isNotEmpty) {
        List<Map<String, dynamic>> user = await db.select("user", "user = ? AND password = ? ", [_emailController.value, _senhaController.value]);

        if (user.length > 0) {
          List<User> list = user.map<User>((json) => User.fromJson(json)).toList();

          for (final e in list) {
            preferences.setString("user", e.user);
            preferences.setInt("id", e.id);
            preferences.setString("name", e.name);

            var url = "${result[0]["url_api"]}data.json";
            Response response = await _sendGet(url);
            if (response.data['news'] != null) {
              print(response.data['news']);
              var rest = response.data["news"] as List;
              List<News> list = rest.map<News>((json) => News.fromJsonWS(json)).toList();
              await db.deleteAll('news');
              for (final e in list) {
                await db.insert('news', e.toJson());
              }
            }
          }
          _stateController.add(LoginState.SUCCESS);
        }
      } else {
        _stateController.add(LoginState.FAIL);
      }
    } on Exception catch (e) {
      _stateController.add(LoginState.FAILLOGIN);
      _getException(e);
    }
  }

  _getException(Exception error) {
    print(error.runtimeType);
    print(error.toString());

    switch (error.runtimeType.toString()) {
      case "SocketException":
        break;
      case "DioError":
        break;
      case "SqfliteDatabaseException":
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.close();
    _senhaController.close();
    _stateController.close();
  }

  _sendGet(url) async {
    print(url);
    var dio = Dio(options);
    Response response = await dio.get(url);
    dio.close();
    return response;
  }
}
