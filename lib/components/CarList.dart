import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weajar/Pages/weCarDetails.dart';
import 'package:weajar/components/textWithPadding.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';

class CarList extends StatelessWidget {
  final List<FullCarInfo> carList;

  CarList({Key key, this.carList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: carList.length,
        itemBuilder: (BuildContext context, int index) {
          return cardCart(carList[index], Colors.white, context);
        });
  }
}

Widget cardCart(FullCarInfo car, Color colorFondo, BuildContext context) {
  var stack = Stack(
    children: [  Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: car.CarImages != null && car.CarImages.length > 0
              ? Image.network(
              'https://api.weajar.com/img/${car.CarImages[0].ImageURL}',
              width: 110,
              height: 80,
              fit: BoxFit.fill)
              : Image.asset("assets/Img/weAjar.png",
              width: 110, height: 80, fit: BoxFit.fill),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWithPadding('${car.CarMake}',
                  vertical: 5, color: Colors.red, fontSize: 24),
              textWithPadding('${car.CarClass}', vertical: 5),
              textWithPadding('${car.Price}'),
            ],
          ),
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
                child: InkWell(
                  child: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pushNamed(context, WeCarDetails.routeName,
                        arguments: car);
                  },
                ),
              ),
            ))
      ],
    )


    ],
  );
  if (car.IsPrime)
    stack.children.add( Positioned(

        left: MediaQuery.of(context).size.width - 100,
        child: Container(
          child: Image.asset(
              "assets/Img/diamond-transparent.png"),
          width: 30,
        )));
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    decoration: BoxDecoration(
        color: colorFondo, borderRadius: BorderRadius.circular(20)),
    height: 130,
    width: double.infinity,
    child:stack




  );
}
