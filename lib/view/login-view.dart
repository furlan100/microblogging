import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:microblogging/bloc/login-bloc.dart';
import 'package:microblogging/models/user.dart';
import 'package:microblogging/view/home-view.dart';
import 'package:microblogging/view/user-edit-view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginBloc = LoginBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen(
      (state) {
        switch (state) {
          case LoginState.SUCCESS:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeView(
                  page: 0,
                ),
              ),
            );
            break;
          case LoginState.FAIL:
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.redAccent,
                title: Text(
                  "Usuário e senha Incorretos",
                ),
                content: Text(
                  "Verifique o usuário e senha informados e tente novamente!",
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
            break;
          case LoginState.FAILLOGIN:
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.redAccent,
                title: Text(
                  "Servidor Offline!",
                ),
                content: Text(
                  "Verifique sua conexão e tente novamente em alguns instantes!",
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
        stream: _loginBloc.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case LoginState.SUCCESS:
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
            case LoginState.FAIL:
            case LoginState.IDLE:
            default:
              return Stack(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.all(16.0),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            'Bem Vindo',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.people,
                          size: 200,
                          //color: Colors.green,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            icon: Icon(Icons.person),
                          ),
                          onChanged: _loginBloc.changeEmail,
                          onSaved: _loginBloc.changeEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Senha",
                            icon: Icon(Icons.vpn_key),
                          ),
                          onChanged: _loginBloc.changePassword,
                          onSaved: _loginBloc.changePassword,
                          obscureText: true,
                        ),
                        Container(
                          height: 10.00,
                        ),
                        Container(
                          height: 50.0,
                          child: StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValid,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.hasData ? _loginBloc.submit : null,
                                color: Colors.black,
                                child: Text(
                                  "Entrar",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 10.00,
                        ),
                        Container(
                          height: 50.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserEditView(
                                    user: new User(),
                                  ),
                                ),
                              );
                            },
                            color: Colors.black,
                            child: Text(
                              "Cadastre-se",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }

  void submit() async {
    _formKey.currentState.save();
    _loginBloc.submit();
  }
}
