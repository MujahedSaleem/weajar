import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:weajar/Pages/weCarDetails.dart';
import 'package:weajar/components/textWithPadding.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';

class CarList extends StatelessWidget {
  final List<FullCarInfo> carList;
  final RefreshCallback onRefresh;
  CarList({Key key, this.carList, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _carlist = carList;
    _carlist.sort((item, item2) => item.compareTo(item2));
    return ListView.builder(
        itemCount: _carlist.length,
        itemBuilder: (BuildContext context, int index) {
          return cardCart(_carlist[index], Colors.white, context,onRefresh);
        });
  }
}

Widget cardCart(FullCarInfo car, Color colorFondo, BuildContext context,RefreshCallback onRefresh) {
  var stack = Stack(
    children: [
      InkWell(
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: car.CarImages != null && car.CarImages.length > 0
                            ? Image.network(
                                'https://api.weajar.com/img/${car.CarImages[0].ImageURL}',
                                width: 110,
                                height: 110,
                                fit: BoxFit.fill)
                            : Image.asset("assets/Img/weAjar.png",
                                width: 110, height: 80, fit: BoxFit.fill),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Container(
                    height: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        textWithPadding('${car.CarMake}',
                            vertical: 5, color: Colors.red, fontSize: 24),
                        textWithPadding('${car.CarClass}', vertical: 5),
                        textWithPadding('${car.Price.floor()} AED / Day'),
                      ],
                    )),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Container(
                alignment: FractionalOffset.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.all(2),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
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
        left: MediaQuery.of(context).size.width - 120,
        top: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            color: Colors.red,
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
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: Text(
                "Premium",
                style: TextStyle(color: Colors.white),
              )),
          width: 70,
        )));
  return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  color: colorFondo, borderRadius: BorderRadius.circular(20)),
              height: 130,
              width: double.infinity,
              child: stack)));
}
