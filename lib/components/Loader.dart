import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double hight;
  const Loader({Key key, this.hight=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.hight ==0?MediaQuery.of(context).size.height:this.hight,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            height: 24,
            width: 24,
          ),
        ));
  }
}
