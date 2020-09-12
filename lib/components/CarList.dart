import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:photo_view/photo_view.dart';
import 'package:weajar/Pages/weCarDetails.dart';
import 'package:weajar/Repo.dart';
import 'package:weajar/components/Booked.dart';
import 'package:weajar/components/HorzLineDivider.dart';
import 'package:weajar/components/VerLineDivider.dart';
import 'package:weajar/components/textWithPadding.dart';
import 'package:intl/intl.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';

class CarList extends StatelessWidget {
  final List<FullCarInfo> carList;
  final RefreshCallback onRefresh;
  final Color color;
  final Color fontColor;
  CarList(
      {Key key,
      this.carList,
      this.onRefresh,
      this.color,
      this.fontColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _carlist = carList;
    _carlist.sort((item, item2) => item.compareTo(item2));
    return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
            itemCount: _carlist.length,
            itemBuilder: (BuildContext context, int index) {
              return cardCart(
                  _carlist[index], Colors.white, context, color, fontColor);
            }));
  }
}

Widget cardCart(FullCarInfo car, Color colorFondo, BuildContext context,
    Color color, Color fontColor) {
  var repo = Repo();
  var stack = Stack(
    children: [
      InkWell(
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: (Intl.getCurrentLocale() == 'ar_AE') ? 0 : 10,
                      right: Intl.getCurrentLocale() == 'ar_AE' ? 10 : 0),
                  child: Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: car.CarImages != null && car.CarImages.length > 0
                        ? Image.network(
                            'https://api.weajar.com/img/${car.CarImages[0].ImageURL}',
                            width: 110,
                            height: 82,
                            fit: BoxFit.fill)
                        : Image.asset("assets/Img/weAjar.png",
                            width: 110, height: 82, fit: BoxFit.fill),
                  ))),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Container(
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        textWithPadding('${car.CarMake}',
                            vertical: 9, color: Colors.red, fontSize: 20),
                        textWithPadding('${car.CarClass}', color: fontColor),
                        textWithPadding(
                            '${car.Price.floor()} ${S.of(context).aedday}',
                            vertical: 14,
                            color: fontColor),
                      ],
                    )),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  margin: EdgeInsets.all(2),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.red,
                  ))
            ],
          ),
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.pushNamed(context, WeCarDetails.routeName,
                arguments: car);
          })
    ],
  );
  if (car.IsPrime)
    stack.children.add(Positioned(
        right: Intl.getCurrentLocale() == 'ar_AE'
            ? MediaQuery.of(context).size.width - 108
            : null,
        left: Intl.getCurrentLocale() == 'en_US'
            ? MediaQuery.of(context).size.width - 108
            : null,
        top: 3,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            color: Color.fromARGB(255, 180, 16, 0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Text(
                "Premium",
                style: TextStyle(color: Colors.white, fontSize: 10),
              )),
          width: 63,
          height: 18,
        )));

  if (car.Status == 0)
    stack.children.add(Positioned(
        left: Intl.getCurrentLocale() == 'ar_AE'
            ? MediaQuery.of(context).size.width - 108
            : null,
        right: Intl.getCurrentLocale() == 'en_US'
            ? MediaQuery.of(context).size.width - 108
            : null,
        bottom: 0,
        top: 70,
        child: Booked()));
  
  var carImage = car.CarImages != null && car.CarImages.length > 0
      ? Image.network(
    'https://api.weajar.com/img/${car.CarImages[0].ImageURL}',
    fit: BoxFit.fitWidth,)
      : Image.asset("assets/Img/weAjar.png",
      width: 110, height: 82, fit: BoxFit.fill);
  var CarDetails = InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [textWithPadding(car.CarMake,
              weight: FontWeight.bold, fontSize: 24, color: Colors.red[800]),Icon(Icons.arrow_forward_ios,color: Colors.red,)],)
          ,
          textWithPadding(car.CarClass,
              vertical: 5, fontSize: 18, color: fontColor ?? Colors.black),
          SizedBox(
            height: 10,
          ),
          HorzLineDivider(
            color: Colors.grey[200],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(7),
                    child:carImage ,
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/Img/calendar.png',
                          height: 30, color: fontColor ?? Colors.black),
                      textWithPadding('${car.Model}',
                          color: fontColor ?? Colors.black)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset('assets/Img/location.png',
                          height: 30, color: fontColor ?? Colors.black),
                      textWithPadding('${repo.allCity.firstWhere((element) => element.ID==car.City).NameEn}',
                          color: fontColor ?? Colors.black)
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          HorzLineDivider(
            color: Colors.grey[200],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWithPadding('${car.Price.floor()} ${S.of(context).aedday}',
                  fontSize: 16, vertical: 14, color: Colors.red[800]),
              if (car.IsPrime) VerLineDivider(),
              if (car.IsPrime)
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Img/premium.png'))),
                ),
              if (car.Status == 0) VerLineDivider(),
              if (car.Status == 0)
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Img/booked.png'))),
                ),
            ],
          )
        ],
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.pushNamed(context, WeCarDetails.routeName, arguments: car);
      });

  return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: CarDetails);
}
