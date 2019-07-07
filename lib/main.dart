import 'package:flutter/material.dart';
import 'package:hackernews_flutter/widgets/home.dart';

import 'model/news_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HackerNews",
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      routes: _buildRoutes(),
      home: Home(
        type: NewsType.TOP,
      ),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      primaryColor: Color(0xffFF6600),
      accentColor: Color(0x99FF6600),
      buttonColor: Color(0xffFF6600),
      backgroundColor: Color(0xffF6F6EF),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          title: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  _buildRoutes() {
    return {
      NewsType.TOP.toString(): (_) => Home(type: NewsType.TOP),
      NewsType.NEWEST.toString(): (_) => Home(type: NewsType.NEWEST),
    };
  }
}
