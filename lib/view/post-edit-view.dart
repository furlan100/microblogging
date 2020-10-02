import 'package:flutter/material.dart';
import 'package:microblogging/bloc/posts-edit-bloc.dart';
import 'package:microblogging/models/posts.dart';
import 'package:microblogging/validators/posts-edit-validators.dart';

class PostsEditView extends StatefulWidget {
  final Posts posts;

  PostsEditView({this.posts});

  @override
  _PostsEditViewState createState() => _PostsEditViewState(posts: posts);
}

class _PostsEditViewState extends State<PostsEditView> with PostsEditValidators {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final PostsEditBloc _postsEditBloc;
  Posts posts;

  _PostsEditViewState({this.posts}) : _postsEditBloc = PostsEditBloc(posts: posts);

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
        title: Text(posts.id == null ? 'Cadastro de Posts' : "${posts.id.toString()} - ${posts.name.toString()}"),
        actions: <Widget>[
          StreamBuilder<bool>(
            initialData: false,
            stream: _postsEditBloc.outLoading,
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
            child: StreamBuilder<Posts>(
              stream: _postsEditBloc.outData,
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
                        decoration: _buildDecoration("Conteúdo"),
                        initialValue: snapshot.data.name,
                        onChanged: _postsEditBloc.saveContent,
                        validator: valContent,
                        maxLines: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: _postsEditBloc.outLoading,
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

      bool success = await _postsEditBloc.save();

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
