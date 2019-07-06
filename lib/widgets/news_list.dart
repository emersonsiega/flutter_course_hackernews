import 'package:flutter/material.dart';
import 'package:hackernews_flutter/model/item.dart';
import 'package:hackernews_flutter/model/news_type.dart';
import 'package:hackernews_flutter/api/hacker_news_api.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<Item> _getById(int id) async {
    final item = await HackerNewsAPI.getStoryById(id);

    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _pages * _itemsPerPage,
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if (_itemIds.isEmpty || _itemIds[index] == null) {
            return Center(
              child: Loading(
                height: 100.0,
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (index == 0) _buildListTitle(),
              _buildItemTile(_itemIds[index]),
              if (index == _pages * _itemsPerPage - 1) _buildLoadButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemTile(int id) {
    return FutureBuilder<Item>(
      future: _getById(id),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
        Item item = snapshot.data;
        if (item == null) {
          return Loading(
            height: 100.0,
          );
        }

        return Container(
          height: 100.0,
          child: Card(
            color: const Color.fromRGBO(230, 230, 230, 0.9),
            child: Center(
              child: ListTile(
                leading: Text(
                  "${_itemIds.indexOf(item.id) + 1}.",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff5E5E5E),
                  ),
                ),
                title: Text(
                  '${item.title}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                  ),
                ),
                subtitle: _buildSubtitle(item),
                onTap: () {
                  _openURL(item.url);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: Center(
              child: Text("Não foi possível abrir URL."),
            ),
          );
        }
      );
    }
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

  Widget _buildSubtitle(Item item) {
    Duration difference = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(item.time * 1000));

    String tempo;
    if (difference.inMinutes < 60) {
      tempo = difference.inMinutes.toString() + " minutos atrás";
    } else if (difference.inHours < 24) {
      tempo = difference.inHours.toString() + " horas atrás";
    } else if (difference.inDays < 30) {
      tempo = difference.inDays.toString() + " dias atrás";
    } else {
      tempo = "a mais de um mês";
    }

    return Text(
      "${item.score} pontos por ${item.by} $tempo",
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xff5e5e5e),
      ),
    );
  }
}
