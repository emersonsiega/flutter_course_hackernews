import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double height;

  Loading({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffFF6600)),
        ),
      ),
    );
  }
}
