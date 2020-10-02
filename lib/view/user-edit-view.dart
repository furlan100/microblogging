import 'package:flutter/material.dart';
import 'package:microblogging/bloc/user-edit-bloc.dart';
import 'package:microblogging/models/user.dart';
import 'package:microblogging/validators/user-edit-validators.dart';

class UserEditView extends StatefulWidget {
  final User user;

  UserEditView({this.user});

  @override
  _UserEditViewState createState() => _UserEditViewState(user: user);
}

class _UserEditViewState extends State<UserEditView> with UserEditValidators {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final UserEditBloc _userEditBloc;
  User user;

  _UserEditViewState({this.user}) : _userEditBloc = UserEditBloc(user: user);

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(labelText: label);
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: Text(user.id == null ? 'Cadastro de Usuário' : "${user.id.toString()} - ${user.name.toString()}"),
        actions: <Widget>[
          StreamBuilder<bool>(
            initialData: false,
            stream: _userEditBloc.outLoading,
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(
                  Icons.save,
                ),
                iconSize: 32.0,
                onPressed: _save,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: StreamBuilder<User>(
              stream: _userEditBloc.outData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: _buildDecoration("Nome"),
                        initialValue: snapshot.data.name,
                        onChanged: _userEditBloc.saveName,
                        validator: valName,
                      ),
                      TextFormField(
                        decoration: _buildDecoration("Usuário"),
                        initialValue: snapshot.data.user,
                        onChanged: _userEditBloc.saveUser,
                        validator: valUser,
                      ),
                      TextFormField(
                        decoration: _buildDecoration("Senha"),
                        initialValue: snapshot.data.password,
                        onChanged: _userEditBloc.savePassword,
                        validator: valPassword,
                        obscureText: true,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: _userEditBloc.outLoading,
            builder: (context, snapshot) {
              return IgnorePointer(
                ignoring: !snapshot.data,
                child: Container(
                  color: snapshot.data ? Colors.black54 : Colors.transparent,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _save() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      bool success = await _userEditBloc.save();

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            success ? "Salvo Com Sucesso" : "Ocorreu um erro ao salvar",
          ),
          duration: Duration(seconds: 1),
        ),
      );

      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );

      Navigator.pop(context, true);
    }
  }
}
