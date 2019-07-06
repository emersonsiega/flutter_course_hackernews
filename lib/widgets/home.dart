import 'package:flutter/material.dart';
import 'package:hackernews_flutter/model/news_type.dart';

import 'hacker_news_icon.dart';
import 'news_list.dart';

class Home extends StatelessWidget {
  final NewsType type;

  Home({this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HackerNews"),
        leading: HackerNewsIcon(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                NewsType.TOP.toString(),
                (_) => false,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.new_releases),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                NewsType.NEWEST.toString(),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: NewsList(
        type: type,
      ),
    );
  }
}
