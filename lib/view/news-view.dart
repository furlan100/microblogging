import 'package:flutter/material.dart';
import 'package:microblogging/bloc/news-bloc.dart';
import 'package:microblogging/models/news.dart';
import 'package:microblogging/view/login-view.dart';
import 'package:microblogging/widgets/news-tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  _NewsViewState();

  NewsBloc _newsBloc = NewsBloc();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: menuAction,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("Sair"),
              )
            ],
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _newsBloc.outNews,
              initialData: [],
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.data.length == 0) {
                  return Center(
                    child: Text("Nenhuma Notícia Encontrada!"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return NewsTile(
                        News.fromJson(
                          snapshot.data[index],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  menuAction(int option) async {
    switch (option) {
      case 1:
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );
        break;
    }
  }
}
