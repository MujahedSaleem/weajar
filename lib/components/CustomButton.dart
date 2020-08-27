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
        minWidth: MediaQuery.of(context).size.width/5,
        height: 60,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
        buttonColor:Colors.white ,
        child: RaisedButton(
          padding: EdgeInsets.all(5),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Image.asset(icon,
                  width: 20),
              SizedBox(height: 10,),
              Text(text,style: TextStyle(fontSize: 14),)
            ],
          ),
        ));

  }
}
