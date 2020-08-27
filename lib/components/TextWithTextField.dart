import 'package:flutter/material.dart';

class TextWithTextfield extends StatelessWidget {
  final String text;
  final double width;
  final TextEditingController controlelr;

  const TextWithTextfield({Key key, this.text, this.width, this.controlelr}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded( child:         Text(text,style: TextStyle(color: Colors.white),),
            ),
        Expanded( child: TextField(
            controller: controlelr,
            style: TextStyle(color: Colors.white)
        ),)


      ],
    ));
  }
}
