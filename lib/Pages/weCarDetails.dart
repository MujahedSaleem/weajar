import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weajar/Pages/EditCar.dart';
import 'package:weajar/Repo.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/CustomButton.dart';
import 'package:weajar/components/CustomCursoul.dart';
import 'package:weajar/components/textWithPadding.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/model/car.dart';
import 'package:weajar/service/AuthenticationService.dart';
import 'package:weajar/service/itemFetcher.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class WeCarDetails extends StatefulWidget {
  static const routeName = 'weCarDetails';

  @override
  _WeCarDetailsState createState() => _WeCarDetailsState();
}

class _WeCarDetailsState extends State<WeCarDetails> {
  static const String whatsApp = "WhatsApp";
  static const String tel = "Tel";
  static const String email = "E-mail";
  static const String map = "map";
  bool isOnDelete = true;
  final repo = Repo();
  final _itemFetcher = ItemFetcher();
  var auth = AuthenticationService();
  final _carService = ItemFetcher();
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
        case _WeCarDetailsState.email:
          return 'mailto:$email?subject=""&body=""';
          break;
        case tel:
          return 'tel:$phone';
        case map:
          if (mapURL.isNotEmpty) return mapURL;
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

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  FullCarInfo car;

  @override
  Widget build(BuildContext context) {
    FullCarInfo _car = ModalRoute.of(context).settings.arguments as FullCarInfo;
    if(car==null)
     car = _car;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF48484A),
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
                        child: CustomAppBar(
                          text: car.CarMake,
                          icon: Icons.arrow_back_ios,
                          iconColor: Colors.white,
                          onPressed: () => Navigator.pop(context),
                        )),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 13, left: 10, right: 10),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: car.CarImages != null &&
                                      car.CarImages.length > 0 &&
                                      car.CarImages.length == 1
                                  ? Image.network(
                                      'https://api.weajar.com/img/${car.CarImages[0].ImageURL}',
                                      fit: BoxFit.cover,
                                      width: 1000.0)
                                  : car.CarImages.length > 1
                                      ? CustomCarousel(
                                          list: car.CarImages.map((item) =>
                                              Container(
                                                child: Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      child: Image.network(
                                                          'https://api.weajar.com/img/${item.ImageURL}',
                                                          fit: BoxFit.cover,
                                                          width: 1000.0)),
                                                ),
                                              )).toList(),
                                        )
                                      : Image.asset("assets/Img/weAjar.png",
                                          width: 110,
                                          height: 80,
                                          fit: BoxFit.fill)),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 13, left: 25, right: 25),
                        child: Row(
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
                                    progName: whatsApp)),
                            CustomButton(
                                text: S.of(context).map,
                                icon: 'assets/Img/map.png',
                                onPressed: () => launchApp(
                                    mapURL:
                                        "https://goo.gl/maps/rVJ52iHZ6rrwKTyk8",
                                    context: context,
                                    progName: map)),
                            CustomButton(
                                text: S.of(context).emailus,
                                icon: 'assets/Img/email.png',
                                onPressed: () => launchApp(
                                    email: "info@weajar.com",
                                    context: context,
                                    progName: email))
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white),
                                color: Color(0xffB41000),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).carPrice,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '${car.Price.floor()} ${S.of(context).aedday}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )
                                    ],
                                  )),
                              width: 300,
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 25, right: 25),
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                    color: Colors.white),
                                child: textWithPadding(
                                    S.of(context).carSpecification,
                                    vertical: 5,
                                    fontSize: 18,
                                    color: Color(0xff757575),
                                    align: TextAlign.center)),
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(top: 10),
                      child:
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //   Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //
                          //     children: [textWithPadding(S.of(context).carMake,
                          //       vertical: 10, color: Colors.white),textWithPadding(S.of(context).carclass,
                          //       vertical: 10, color: Colors.white),    textWithPadding(S.of(context).model,
                          //       vertical: 10, color: Colors.white),textWithPadding(S.of(context).type,
                          //       vertical: 10, color: Colors.white), textWithPadding(S.of(context).incType,
                          //       vertical: 10, color: Colors.white), textWithPadding(
                          //       S.of(context).deliveryToYouLcation,
                          //       vertical: 10,
                          //       color: Colors.white)],),
                          //   Column(children: [ textWithPadding(car.CarMake,
                          //       vertical: 10, color: Colors.white),  textWithPadding(car.CarClass,
                          //       vertical: 10, color: Colors.white),    textWithPadding('${car.Model ?? " "}',
                          //       vertical: 10, color: Colors.white), textWithPadding(getCarType(car.Seats),
                          //       vertical: 10, color: Colors.white),textWithPadding(
                          //       getInsuranceType(
                          //           car.InsuranceType ?? "", context),
                          //       vertical: 10,
                          //       color: Colors.white), textWithPadding(
                          //       car.WithDelivery
                          //           ? S.of(context).yes
                          //           : S.of(context).no,
                          //       vertical: 10,
                          //       color: Colors.white)],)
                          // ],)
                          //

                          Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWithPadding(S.of(context).carMake,
                                  vertical: 10, color: Colors.white),
                              textWithPadding(car.CarMake,
                                  vertical: 10, color: Colors.white)
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWithPadding(S.of(context).carclass,
                                    vertical: 10, color: Colors.white),
                                textWithPadding(car.CarClass,
                                    vertical: 10, color: Colors.white)
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWithPadding(S.of(context).model,
                                    vertical: 10, color: Colors.white),
                                textWithPadding('${car.Model ?? " "}',
                                    vertical: 10, color: Colors.white)
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWithPadding(S.of(context).type,
                                    vertical: 10, color: Colors.white),
                                textWithPadding(getCarType(car.Seats),
                                    vertical: 10, color: Colors.white)
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWithPadding(S.of(context).incType,
                                    vertical: 10, color: Colors.white),
                                textWithPadding(
                                    getInsuranceType(
                                        car.InsuranceType ?? "", context),
                                    vertical: 10,
                                    color: Colors.white)
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWithPadding(
                                    S.of(context).deliveryToYouLcation,
                                    vertical: 10,
                                    color: Colors.white),
                                textWithPadding(
                                    car.WithDelivery
                                        ? S.of(context).yes
                                        : S.of(context).no,
                                    vertical: 10,
                                    color: Colors.white)
                              ])
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
                                    color: Colors.white),
                                child: textWithPadding(S.of(context).rentingreq,
                                    vertical: 5,
                                    fontSize: 18,
                                    color: Color(0xff757575),
                                    align: TextAlign.center)),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.only(top: 10, left: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWithPadding(S.of(context).drivinglicens,
                                    vertical: 6, color: Colors.white),
                                textWithPadding(S.of(context).deposit,
                                    vertical: 6, color: Colors.white),
                                textWithPadding(S.of(context).minAge,
                                    vertical: 6, color: Colors.white),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                textWithPadding(
                                    getDrivingLicense(
                                        car.DrivingLicense, context),
                                    vertical: 6,
                                    fontSize: getDrivingLicense(
                                                    car.DrivingLicense, context)
                                                .length >
                                            14
                                        ? 11
                                        : 16,
                                    color: Colors.white),
                                textWithPadding(
                                    '${car.InsuranceAmount.floor() ?? "0"} ${S.of(context).aed}',
                                    vertical: 6,
                                    fontSize: 14,
                                    color: Colors.white),
                                textWithPadding('${car.MinimumAge ?? ""}',
                                    fontSize: 14,
                                    vertical: 6,
                                    color: Colors.white),
                              ],
                            )
                          ],
                        )),
                    if (!auth.IsTokenNotActive())
                      SizedBox(
                        height: 10,
                      ),
                    if (!auth.IsTokenNotActive())
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              color: Color.fromARGB(200, 18, 65, 206),
                              child: Text(
                                S.of(context).edit,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color: Color.fromARGB(200, 18, 65, 206))),
                              onPressed: () async {
                                Car carfull = repo.fullCarInfo
                                    .firstWhere((e) => e.ID == car.ID);
                                var result = await Navigator.of(context)
                                    .pushNamed(EditCar.routeName, arguments: {
                                  'carMaker': repo.CarMakers,
                                  'car': carfull
                                });
                                if (result != null) {
                                  var success =  await _itemFetcher.UpdateCar(result);
                                  if (success is bool && !success) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Something went wrong"),
                                    ));
                                  } else {
                                    setState(() {
                                      var e = success as Car;
                                     Car carc =  repo.fullCarInfo
                                          .firstWhere((e) => e.ID == e.ID);
                                      carc = e;
                                      var carMake = repo.CarMakers.firstWhere(
                                          (element) =>
                                              element.ID == e.CarMakeID);
                                      var carInfo = FullCarInfo(
                                          CarImages:
                                              List<CarImage>.from(e.CarImages)
                                                  .toList(),
                                          CarClass:
                                              carMake.CarClasses.firstWhere(
                                                  (element) =>
                                                      element.ID ==
                                                      e.CarClassID).NameEn,
                                          CarMake: carMake.NameEn,
                                          Model: e.Model,
                                          ID:e.ID,
                                          DrivingLicense: e.DrivingLicense,
                                          MinimumAge: e.MinimumAge,
                                          InsuranceType: e.InsuranceType,
                                          InsuranceAmount: e.InsuranceAmount,
                                          Seats: e.Seats,
                                          City: e.CityID,
                                          Status: e.Status,
                                          WithDelivery: e.WithDelivery,
                                          IsPrime: e.IsPrime ?? false,
                                          Price: e.Price);
                                      car = carInfo;

                                    });
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    if (!auth.IsTokenNotActive())
                      SizedBox(
                        height: 10,
                      ),
                    if (!auth.IsTokenNotActive())
                      SizedBox(
                        height: 10,
                      ),
                    if (!auth.IsTokenNotActive())
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonTheme(
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                              color: Color.fromARGB(200, 237, 56, 38),
                              child: Text(
                                S.of(context).deletecar,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color: Color.fromARGB(200, 237, 56, 38))),
                              onPressed: () {
                                showAlertDialog(context, car);
                              },
                            ),
                          )
                        ],
                      ),
                    if (!auth.IsTokenNotActive())
                      SizedBox(
                        height: 10,
                      ),
                  ],
                )
              ])));
        })));
  }

  showAlertDialog(BuildContext context, FullCarInfo car) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(S.of(context).cancel),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(S.of(context).approve),
      onPressed: () {
        if (isOnDelete) {
          _carService.DeleteCar(car.ID, auth.getCurrentUser().ID).then((a) {
            isOnDelete = false;
            if (a) {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pop({'reload': true});
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }
          });
        }
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(S.of(context).deletecar),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(S.of(context).sureDelete(car.CarMake)),
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // ow the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String getDrivingLicense(String drivingLicense, BuildContext context) {
    switch (drivingLicense) {
      case 'LocalDrivingLicense':
        return S.of(context).local;
        break;
      case 'InternationalDrivingLicense':
        return S.of(context).International;
      case 'SpecificTypeIsNotRequired':
        return S.of(context).SpecificType;

        return '';
    }
  }

  String getInsuranceType(String inc, BuildContext context) {
    switch (inc) {
      case 'FullInsurance':
        return S.of(context).full;
        break;
      case 'ThirdPartyInsurance':
        return S.of(context).third;

        return '';
    }
  }

  String getCarType(int seats) {
    switch (seats) {
      case 5:
        return 'Hatchback';
      case 4:
        return 'Coupe';
      case 3:
        return 'SUV';
      case 2:
        return 'Sedan';
      case 1:
        return 'Cross over';
    }
  }
}
