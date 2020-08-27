import 'package:flutter/material.dart';

class TextWithText extends StatelessWidget {
  final String text;
  final double width;
  final String text2;

  const TextWithText({Key key, this.text, this.width, this.text2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded( child:         Text(text,style: TextStyle(color: Colors.white),),
            ),
            Expanded( child: Text(
                text2,
                style: TextStyle(color: Colors.white)
            ),)


          ],
        ));
  }
}
