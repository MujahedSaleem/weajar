import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/SideDrawer.dart';
import 'package:weajar/generated/l10n.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = 'abouts';

  final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[800],
        drawer: SideDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        }, child: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: new EdgeInsets.all(8.0),
                        child: CustomAppBar(
                            text: S.of(context).aboutus,
                            icon: Icons.menu,
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
                        Text("WEAJAR is the biggest car rental company in the Middle East. WEAJAR offers an efficient, convenient and elegant way of renting cars to many people and at any time." +
                            "              Eradicating the conventional ways of renting a car, WE AJAR brings convenience to you at its finest." +
                            "Dedicated to making car rental as simple as possible, we help customers find the best options to book the perfect car for them."
                        ,style: TextStyle(fontSize: 14,color: Colors.white),),
                        SizedBox(
                          height: 20,
                        ),
                        Text("We want to bring the world to you. From choosing a suitable car to finding the best price, we want you to have all the options at your fingertips. " +
                            "That's why we're focused on making car rental better for everyone. This spirit shines through everything we do.",style: TextStyle(fontSize: 14,color: Colors.white))
                      ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Want to Join us? Contact us with pleasure",style: TextStyle(fontSize: 14,color: Colors.white)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/Img/instagram.png",
                              width: 30,
                            ),
                            SizedBox(width: 10,),
                            InkWell(child: Image.asset(
                              "assets/Img/email-white.png",
                              width: 40,
                            ) ,onTap: (){
                              launch('mailto:almillionairerentacar@gmail.com?subject=""&body=""');
                            },)

                          ],
                        )
                      ],
                    )
                  ]));
        }))));
  }
}
