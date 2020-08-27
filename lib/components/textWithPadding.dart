import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textWithPadding(String text,
    {Color color = Colors.black,
    double fontSize = 14,
    double vertical = 0.0,
      TextAlign align,
    double horizontal = 0.0}) {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: fontSize),
        textAlign:align ,
      ));
}
