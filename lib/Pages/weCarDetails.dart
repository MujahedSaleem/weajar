import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/CustomButton.dart';
import 'package:weajar/components/CustomCursoul.dart';
import 'package:weajar/components/textWithPadding.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class WeCarDetails extends StatelessWidget {
  static const String whatsApp = "WhatsApp";
  static const String tel = "Tel";
  static const String email = "E-mail";
  static const String map = "map";
  void launchApp(
      {String phone,
      String message,
      String email,
      double latitude,
      double longitude,
        String mapURL,
      BuildContext context,
      String progName}) async {
    String url() {
      switch (progName) {
        case whatsApp:
          if (Platform.isIOS) {
            return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
          } else {
            return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
          }
          break;
        case WeCarDetails.email:
          return 'mailto:$email?subject=""&body=""';
          break;
        case tel:
          return 'tel:$phone';
        case map:
          if (mapURL.isNotEmpty)
            return mapURL;
          return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).dontHaveProg(progName)),
      ));
    }
  }

  static const routeName = 'weCarDetails';
   final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final FullCarInfo car =
        ModalRoute.of(context).settings.arguments as FullCarInfo;

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[800],
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  child: Column(children: [
                Column(
                  children: [
                    Padding(
                        padding: new EdgeInsets.all(8.0),
                        child:CustomAppBar(text: car.CarMake,icon: Icons.arrow_back_ios,onPressed: ()=>Navigator.pop(context),)),
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 13, left: 10, right: 10),
                          child: car.CarImages != null &&
                                  car.CarImages.length > 0
                              ? CustomCarousel(
                                  list: car.CarImages.map((item) => Container(
                                        child: Container(
                                          margin: EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              child: Image.network(
                                                  'https://api.weajar.com/img/${item.ImageURL}',
                                                  fit: BoxFit.cover,
                                                  width: 1000.0)),
                                        ),
                                      )).toList(),
                                )
                              : Image.asset("assets/Img/weAjar.png",
                                  width: 110, height: 80, fit: BoxFit.fill),
                        ),
                        if (car.IsPrime)
                          Positioned(
                              left: MediaQuery.of(context).size.width - 100,
                              child: Container(
                                child: Image.asset(
                                    "assets/Img/diamond-transparent.png"),
                                width: 70,
                              )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13, left: 25, right: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomButton(
                                  text: S.of(context).callNow,
                                  icon: 'assets/Img/call.png',
                                  onPressed: () => launchApp(
                                      phone: "+971508883337",
                                      context: context,
                                      progName: tel)),
                              CustomButton(
                                  text: S.of(context).whatsapp,
                                  icon: 'assets/Img/whatsapp.png',
                                  onPressed: () => launchApp(
                                      phone: "+971508883337",
                                      message: " ",
                                      context: context,
                                      progName: whatsApp))
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomButton(
                                  text: S.of(context).map,
                                  icon: 'assets/Img/map.png',
                                  onPressed: () => launchApp(
                                      mapURL: "https://goo.gl/maps/rVJ52iHZ6rrwKTyk8",
                                      context: context,
                                      progName: map)),
                              CustomButton(
                                  text: S.of(context).emailus,
                                  icon: 'assets/Img/email.png',
                                  onPressed: () => launchApp(
                                      email: "almillionairerentacar@gmail.com",
                                      context: context,
                                      progName: email))
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 50, left: 25, right: 25),
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white),
                                child:textWithPadding( S.of(context).carSpecification,vertical: 5,fontSize: 18,align: TextAlign.center)),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              '${car.Price.floor()} AED',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWithPadding(S.of(context).carMake,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                                textWithPadding(S.of(context).carclass,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                                textWithPadding(S.of(context).model,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                                textWithPadding(S.of(context).type,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                                textWithPadding(S.of(context).incType,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                                textWithPadding(
                                    S.of(context).deliveryToYouLcation,
                                    vertical: 10,
                                    horizontal: 10,color: Colors.white),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5.5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                textWithPadding(car.CarMake, vertical: 10,color: Colors.white),
                                textWithPadding(car.CarClass, vertical: 10,color: Colors.white),
                                textWithPadding('${car.Model ?? " "}',
                                    vertical: 10,color: Colors.white),
                                textWithPadding(S.of(context).type,
                                    vertical: 10,color: Colors.white),
                                textWithPadding(car.InsuranceType ?? "",
                                    vertical: 10,color: Colors.white),
                                car.WithDelivery
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    : Icon(Icons.cancel, color: Colors.red),
                              ],
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white),
                        child:textWithPadding( S.of(context).rentingreq,vertical: 5,fontSize: 18,align: TextAlign.center)),

                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWithPadding(S.of(context).drivinglicens,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                                textWithPadding(S.of(context).deposit,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                                textWithPadding(S.of(context).minAge,
                                    vertical: 10, horizontal: 10,color: Colors.white),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                textWithPadding(car.DrivingLicense ?? "",
                                    vertical: 10,color: Colors.white),
                                textWithPadding('${car.InsuranceAmount.floor() ?? "0"} AED',
                                    vertical: 10,color: Colors.white),
                                textWithPadding('${car.MinimumAge ?? ""}',
                                    vertical: 10,color: Colors.white),
                              ],
                            ))
                          ],
                        )),
                  ],
                )
              ])));
        })));
  }
}
