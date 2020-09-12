import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double hight;
  final Color color;
  const Loader({Key key, this.hight=0, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.hight ==0?MediaQuery.of(context).size.height:this.hight,
        decoration: BoxDecoration(
          color: Color.fromARGB(250, 32, 37, 42),
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
