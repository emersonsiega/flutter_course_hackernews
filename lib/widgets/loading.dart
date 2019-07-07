import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double size;

  Loading({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size,
      width: this.size,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
