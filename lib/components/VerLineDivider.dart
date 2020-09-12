import 'package:flutter/material.dart';

class VerLineDivider extends StatelessWidget {

  const VerLineDivider({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return     Container(
        height: MediaQuery.of(context).size.width * 0.1,
        width: 2,
        decoration: BoxDecoration(
            color:  Colors.grey[200],

        ));
  }
}
