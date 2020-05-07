import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String text;

  const CustomCircleAvatar({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      height: 80,
      width: 80,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.grey[700]),
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: 42, letterSpacing: 2),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
