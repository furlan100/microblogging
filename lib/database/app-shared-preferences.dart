import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }
}
