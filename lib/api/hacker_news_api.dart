import 'package:hackernews_flutter/model/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HackerNewsAPI {
  static const String BASE_API = "https://hacker-news.firebaseio.com/v0/";

  static Future<List<int>> getTopStories() async {
    try {
      http.Response response = await http.get(BASE_API + "topstories.json");

      if (response.statusCode == 200) {
        final source = json.decode(response.body);
        return List<int>.from(source);
      }
    } catch (ex) {
      print(ex.toString());
    }

    return [];
  }

  static Future<List<int>> getNewStories() async {
    try {
      http.Response response = await http.get(BASE_API + "newstories.json");

      if (response.statusCode == 200) {
        final source = json.decode(response.body);
        return List<int>.from(source);
      }
    } catch (ex) {
      print(ex.toString());
    }

    return [];
  }

  static Future<Item> getStoryById(int id) async {
    try {
      http.Response response = await http.get(BASE_API + "item/$id.json");

      if (response.statusCode == 200) {
        final source = json.decode(response.body);
        return Item.fromJson(source);
      }
    } catch (ex) {
      print(ex.toString());
    }

    return null;
  }
}
