import 'package:flutter/material.dart';
import 'package:microblogging/view/news-view.dart';
import 'package:microblogging/view/post-view.dart';

class HomeView extends StatefulWidget {
  final int page;

  HomeView({this.page});

  @override
  _HomeViewState createState() => _HomeViewState(page: page);
}

class _HomeViewState extends State<HomeView> {
  int page;

  _HomeViewState({this.page});

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.page,
        onTap: (page) {
          _pageController.animateToPage(
            page,
            duration: Duration(microseconds: 500),
            curve: Curves.ease,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_releases,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              "News",
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.comment,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              "Posts",
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            this.page = page;
          });
        },
        children: <Widget>[
          NewsView(), //0
          PostView(), //1
        ],
      ),
    );
  }
}
