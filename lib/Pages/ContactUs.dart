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

class ContactUs extends StatelessWidget {
  static const String routeName = 'ContactUs';
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

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
                      image: AssetImage('assets/Img/bugatti.png'),
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
                            text: S.of(context).contactus,
                            icon: Icons.menu,
                            iconColor: Colors.white,
                            onPressed: () {
                              if (scaffoldKey.currentState.hasDrawer)
                                scaffoldKey.currentState.openDrawer();
                            })),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Img/weAjar.png'))),
                                height: constraints.maxHeight * 0.2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.20,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/Img/mail.png",
                                            width: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "WeAjar",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        launch(
                                            'mailto:info@weajar.com?subject=""&body=""');
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/Img/instagram.png",
                                            width: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "WeAjar",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        launch(
                                            'http://www.instagram.com/weajar');
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/Img/fb.png",
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "WeAjar",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white),
                                            ),
                                          ]),
                                      onTap: () {
                                        launch('http://www.fb.com/weajarr');
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/Img/callus.png",
                                            width: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Call Us",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        launch('tel:+971545060999');
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '© WeAjar.com',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ]),
                                        onTap: () =>
                                            launch('https://www.weajar.com'))
                                  ]),
                            ],
                          ),
                        )
                      ],
                    )
                  ])));
        }))));
  }
}
