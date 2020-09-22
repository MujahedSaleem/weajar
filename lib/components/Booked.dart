import 'package:flutter/material.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:intl/intl.dart';

class Booked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(

        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY((Intl.getCurrentLocale() == 'ar_AE') ? 3.14:0),
          child:  Image.asset('assets/Img/booked.png'),
        ),

      ),Positioned(top: Intl.getCurrentLocale() == 'ar_AE'?-7:-2,child:
      Text(
        S.of(context).booked,
        style: TextStyle(color: Colors.white,fontSize: 12),
      ))
    ]);
  }
}
