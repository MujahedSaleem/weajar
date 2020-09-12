import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/SideDrawer.dart';
import 'package:weajar/generated/l10n.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = 'abouts';

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF48484A),
        drawer: SideDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        }, child: SafeArea(child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: new EdgeInsets.all(8.0),
                        child: CustomAppBar(
                            text: S.of(context).aboutus,
                            icon: Icons.menu,
                            iconColor: Colors.white,
                            onPressed: () {
                              if (scaffoldKey.currentState.hasDrawer)
                                scaffoldKey.currentState.openDrawer();
                            })),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          S.of(context).about1,
                          style: TextStyle(
                              fontSize: 14, color: Colors.white, height: 1.5),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            S.of(context).about2,
                            style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.white,
                                height: 1.5)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            S.of(context).about3,
                            style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Colors.white)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            S.of(context).about4,
                            style: TextStyle(
                                fontSize: 15.5, height: 1.5, color: Colors.white))
                      ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text( S.of(context).about5,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ InkWell(
                            child: Image.asset(
                              "assets/Img/fb.png",
                              width: 30,
                            ),
                            onTap: () {
                              launch(
                                  'http://www.fb.com/weajarr');
                            },
                          ),

                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: Image.asset(
                                "assets/Img/instagram.png",
                                width: 25,
                              ),
                              onTap: () {
                                launch(
                                    'http://www.instagram.com/weajar');
                              },
                            ),

                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: Image.asset(
                                "assets/Img/email-white.png",
                                width: 40,
                              ),
                              onTap: () {
                                launch(
                                    'mailto:info@weajar.com?subject=""&body=""');
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )
                  ])))
        )));
  }
}
