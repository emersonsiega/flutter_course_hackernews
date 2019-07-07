import 'package:flutter/material.dart';
import 'package:hackernews_flutter/model/news_type.dart';
import 'package:hackernews_flutter/api/hacker_news_api.dart';
import 'package:intl/intl.dart';

import 'item_card.dart';
import 'loading.dart';

class NewsList extends StatefulWidget {
  final NewsType type;

  NewsList({this.type});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final _itemsPerPage = 10;
  List<int> _itemIds;
  int _pages;

  @override
  void initState() {
    super.initState();
    _itemIds = [];
    _pages = 1;

    Future.delayed(Duration.zero, () {
      if (widget.type == NewsType.TOP) {
        _getNewsList();
      } else {
        _getNewestList();
      }
    });
  }

  Future<void> _getNewsList() async {
    final list = await HackerNewsAPI.getTopStories();

    setState(() {
      _itemIds = list;
    });
  }

  Future<void> _getNewestList() async {
    final list = await HackerNewsAPI.getNewStories();

    setState(() {
      _itemIds = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_itemIds.isEmpty) {
      return Center(
        child: Loading(
          size: 100.0,
        ),
      );
    }


    return Container(
      child: ListView.builder(
        itemCount: _pages * _itemsPerPage,
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (index == 0) _buildListTitle(),
              ItemCard(
                itemId: _itemIds[index],
                itemIndex: index,
              ),
              if (index == _pages * _itemsPerPage - 1) _buildLoadButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      onPressed: () {
        setState(() {
          _pages += 1;
        });
      },
      child: Text(
        "Carregar mais..",
        style: TextStyle(
          color: Color(0xff333333),
        ),
      ),
    );
  }

  Widget _buildListTitle() {
    String text;
    if (widget.type == NewsType.TOP) {
      text = "Top " + new DateFormat("d MMMM").format(DateTime.now());
    } else {
      text = "Últimas notícias";
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
