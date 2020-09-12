import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weajar/Pages/login.dart';
import 'package:weajar/Pages/weCarList.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/Loader.dart';
import 'package:weajar/components/SideDrawer.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/model/LoginUser.dart';
import 'package:weajar/service/AuthenticationService.dart';
import 'package:weajar/service/UserService.dart';

class Registration extends StatefulWidget {
  static const String routeName = 'registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var authService = AuthenticationService();

  TextEditingController _emailControlelr;
  TextEditingController _passwordControlelr;
  TextEditingController _confirmpasswordControlelr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailControlelr = TextEditingController();
    _passwordControlelr = TextEditingController();
    _confirmpasswordControlelr = TextEditingController();
    if (authService.IsTokenNotActive()) {
      authService.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, WeCarList.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: SideDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        }, child: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Img/signup.jpg'),
                      fit: BoxFit.cover)),
              height: constraints.maxHeight,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Padding(
                        padding: new EdgeInsets.all(8.0),
                        child: CustomAppBar(
                            text: S.of(context).registration,
                            icon: Icons.menu,
                            iconColor: Colors.white,
                            onPressed: () {
                              if (scaffoldKey.currentState.hasDrawer)
                                scaffoldKey.currentState.openDrawer();
                            })),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Img/weAjar.png'))),
                      height: constraints.maxHeight * 0.2,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.36,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: _emailControlelr,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: S.of(context).email,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                    ),
                                  ))),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: _passwordControlelr,
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: S.of(context).password,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                    ),
                                  ))),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: TextField(
                                    controller: _confirmpasswordControlelr,
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: S.of(context).confirmPassword,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                    ),
                                  ))),
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: ButtonTheme(
                              height: 50,
                              minWidth: MediaQuery.of(context).size.width * 0.8,
                              child: RaisedButton(
                                color: Color.fromARGB(255, 237, 56, 38),
                                child: Text(
                                  S.of(context).registration,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 56, 38))),
                                onPressed: () async {
                                  if (_passwordControlelr.value.text.trim() ==
                                          '' ||
                                      _emailControlelr.value.text.trim() ==
                                          '' ||
                                      _passwordControlelr.value.text !=
                                          _confirmpasswordControlelr
                                              .value.text) {
                                    Fluttertoast.showToast(
                                        msg: "Password not match or email is empty ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    return;
                                  }
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Loader(
                                        hight:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                      )
                                    ],
                                  );
                                  var result = await UserService().CreateUser(
                                      LoginUser(
                                          Email: _emailControlelr.value.text,
                                          Password:
                                              _passwordControlelr.value.text));
                                  if (result) {
                                    Fluttertoast.showToast(
                                        msg: "User Created Success ",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "User name or password is wrong ",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).hasAccount,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Login.routeName);
                                },
                                child: Text(
                                  S.of(context).signIn,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: InkWell(
                          child: Text(
                            '© WeAjar.com',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () => launch('https://www.weajar.com')),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ])));
        }))));
  }
}
