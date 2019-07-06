import 'package:flutter/material.dart';

class HackerNewsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              "Y",
              style: TextStyle(
                color: Color(0xffFF6600),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
