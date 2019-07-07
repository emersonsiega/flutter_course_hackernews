import 'package:flutter/material.dart';
import 'package:hackernews_flutter/api/hacker_news_api.dart';
import 'package:hackernews_flutter/model/item.dart';
import 'package:url_launcher/url_launcher.dart';

import 'loading.dart';

class ItemCard extends StatelessWidget {
  final int itemId;
  final int itemIndex;

  ItemCard({
    this.itemId,
    this.itemIndex,
  });

  Future<Item> _getById(int id) async {
    final item = await HackerNewsAPI.getStoryById(id);

    return item;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item>(
      future: _getById(itemId),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
        Item item = snapshot.data;
        if (item == null) {
          return _buildCardContainer(
            child: Loading(
              size: 30.0,
            ),
          );
        }

        return _buildCardContainer(
          child: ListTile(
            leading: Text(
              "${itemIndex + 1}.",
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
              _openURL(
                url: item.url,
                context: context,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCardContainer({Widget child}) {
    return Container(
      height: 100.0,
      child: Card(
        color: const Color.fromRGBO(230, 230, 230, 0.9),
        child: Center(
          child: child,
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

  void _openURL({String url, BuildContext context}) async {
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
          });
    }
  }
}
