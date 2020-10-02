import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microblogging/view/home-view.dart';
import 'package:microblogging/view/login-view.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Microblogging - Boticário',
      theme: ThemeData(
          primaryColor: Colors.black
      ),
      home: MyHomePage(
        title: 'Microblogging - Boticário',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      title: new Text(
        'Bem Vindo ao Microblogging \r\n '
        'Grupo Boticário \r\n '
        'Desenvolvido : Guilherme Furlan \r\n '
        'E-mail : furlan100@gmail.com \r\n'
        'WhatsApp : 49 9 9953-2934 \r\n',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
      image: Image.asset("assets/logo.png", fit: BoxFit.none),
      photoSize: 150.0,
      loaderColor: Colors.red,
      loadingText: Text("Carregando..."),
      gradientBackground: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.grey,
          Colors.black12,
        ],
      ),
      navigateAfterSeconds: FutureBuilder<SharedPreferences>(
        future: getSharedPreferences(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.getInt('id') != null)
              return HomeView(
                page: 0,
              );
            else {
              return LoginView();
            }
          }
        },
      ),
    );
  }
}

Future<SharedPreferences> getSharedPreferences() async {
  return await SharedPreferences.getInstance();
}
