import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weajar/Pages/weCarList.dart';


Widget _home;
Function _customFunction;
String _imagePath;
int _duration;
CustomSplashType _runfor;
Color _backGroundColor;
String _animationEffect;
double _logoSize;


Map<dynamic, Widget> _outputAndHome = {};

class SplashScreen extends StatefulWidget {
  SplashScreen(
      {@required String imagePath,
        @required Widget home,
        Function customFunction,
        int duration=5000,
        CustomSplashType type,
        Color backGroundColor = const Color(0xff760010),
        String animationEffect = 'fade-in',
        double logoSize = 500.0,
        Map<dynamic, Widget> outputAndHome}) {


    _home = WeCarList();
    _duration = duration;
    _customFunction = customFunction;
    _imagePath = 'assets/Img/introoo.png';
    _runfor = type;
    _outputAndHome = outputAndHome;
    _backGroundColor = backGroundColor;
    _animationEffect = animationEffect;
  }

  @override
  _CustomSplashState createState() => _CustomSplashState();
}

class _CustomSplashState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _animation = Tween(begin: 70.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.reset();
    _animationController.dispose();
    super.dispose();
  }

  navigator(home) {
    Navigator.of(_scaffoldKey.currentContext??context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => home));
  }

  Widget _buildAnimation() {
    _logoSize=MediaQuery.of(_scaffoldKey.currentContext??context).size.height;
    switch(_animationEffect) {
      case 'fade-in': {
        return FadeTransition(
            opacity: _animation,
            child: Center(
                child:
                SizedBox(height: _logoSize, child: Image.asset(_imagePath))));
      }

      case 'zoom-in': {
        return ScaleTransition(
            scale: _animation,
            child: Center(
                child:
                SizedBox(height: _logoSize, child: Image.asset(_imagePath))));
      }
      case 'zoom-out': {
        return ScaleTransition(
            scale: Tween(begin: 1.5, end: 0.6).animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInCirc)),
            child: Center(
                child:
                SizedBox(height: _logoSize, child: Image.asset(_imagePath))));
      }
      case 'top-down': {
        return SizeTransition(
            sizeFactor: _animation,
            child: Center(
                child:
                SizedBox(height: _logoSize, child: Image.asset(_imagePath))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _runfor == CustomSplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((value) {
      var res = _customFunction();
      //print("$res+${_outputAndHome[res]}");
      Future.delayed(Duration(milliseconds: _duration)).then((value) {
        Navigator.of(_scaffoldKey.currentContext??context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => _outputAndHome[res]));
      });
    })
        : Future.delayed(Duration(milliseconds: _duration)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => _home));
    });

    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: _backGroundColor,
        body: _buildAnimation()
    );
  }
}
