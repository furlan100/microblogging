import 'package:flutter/material.dart';
import 'package:microblogging/models/news.dart';

class NewsTile extends StatelessWidget {
  final News news;

  NewsTile(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Image.network(
                    "https://malucellidotlive.files.wordpress.com/2019/06/viewimage.aspx_-2.jpeg?w=1100&h=550&crop=1",
                  ),
                  Text(news.content),
                  Text(news.name),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
