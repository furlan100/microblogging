import 'package:flutter/material.dart';
import 'package:microblogging/models/posts.dart';
import 'package:intl/intl.dart';
import 'package:microblogging/view/post-edit-view.dart';

class PostsTile extends StatelessWidget {
  final Posts posts;

  PostsTile(this.posts);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(
            posts.content,
          ),
          subtitle: Text("${posts.name} - ${DateFormat("dd/MM/yyyy H:m:s").format(DateTime.parse(posts.createdAt))} "),
          isThreeLine: true,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostsEditView(
                  posts: posts,
                ),
              ),
            );
          }),
    );
  }
}
