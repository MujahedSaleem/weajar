import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weajar/Pages/weCarList.dart';


Widget _home;
Function _customFunction;
String _imagePath;
int _duration;
CustomSplashType _runfor;
double _logoSize;


Map<dynamic, Widget> _outputAndHome = {};

class SplashScreen extends StatefulWidget {
  SplashScreen(
      {@required String imagePath,
        @required Widget home,
        Function customFunction,
        int duration=4000,
        CustomSplashType type,
        Color backGroundColor = const Color(0xff760010),
        String animationEffect = 'fade-in',
        double logoSize = 500.0,
        Map<dynamic, Widget> outputAndHome}) {


    _home = WeCarList();
    _duration = duration;
    _customFunction = customFunction;
    _imagePath = 'assets/SplashScreen.gif';
    _runfor = type;
    _outputAndHome = outputAndHome;
  }

  @override
  _CustomSplashState createState() => _CustomSplashState();
}

class _CustomSplashState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
  }


  navigator(home) {
    Navigator.of(_scaffoldKey.currentContext??context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => home));
  }


  @override
  Widget build(BuildContext context) {

  Future.delayed(Duration(milliseconds: _duration)).then((value) {
      Navigator.of(context).pushReplacementNamed(WeCarList.routeName);
    });

    return Scaffold(
      key: _scaffoldKey,

        body:
            SizedBox( child: Image.asset('assets/SplashScreen.gif',fit:BoxFit.cover,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,))
    );
  }
}
