import 'package:flutter/material.dart';
import 'package:microblogging/bloc/posts-bloc.dart';
import 'package:microblogging/models/posts.dart';
import 'package:microblogging/view/post-edit-view.dart';
import 'package:microblogging/widgets/posts-tile.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  _PostViewState();

  PostsBloc _potsBloc = PostsBloc();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostsEditView(
                posts: Posts(),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _potsBloc.outPosts,
              initialData: [],
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.data.length == 0) {
                  return Center(
                    child: Text("Nenhum post encontrado..."),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PostsTile(
                        Posts.fromJson(
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
}
