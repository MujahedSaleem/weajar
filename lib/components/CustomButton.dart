import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback  onPressed;
  CustomButton({this.text,this.icon,@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: MediaQuery.of(context).size.width/2.5,
        height: 50,
        buttonColor:Colors.white ,
        child: RaisedButton(
          padding: EdgeInsets.all(0),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Image.asset(icon,
                  width: 30),
              SizedBox(width: 10,),
              Text(text,style: TextStyle(fontSize: 18),)
            ],
          ),
        ));

  }
}
