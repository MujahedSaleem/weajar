import 'package:flutter/material.dart';

class HorzLineDivider extends StatelessWidget {
  final double width;
  final Color color;

  const HorzLineDivider({Key key, this.width=0, this.color=Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return     Container(
        height: 2,
        width: width ==0 ? MediaQuery.of(context).size.width * 0.9:width,
        decoration: BoxDecoration(
            color: color,

        ));
  }
}
