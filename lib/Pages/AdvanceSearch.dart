import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/CustomDropDown.dart';
import 'package:weajar/components/HorzLineDivider.dart';
import 'package:weajar/components/VerLineDivider.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/model/CarMake.dart';
import 'package:weajar/model/Isearch.dart';
import 'package:weajar/model/carSearch.dart';

class AdvanceSearch extends StatefulWidget {
  static const String routeName = "AdvanceSearch";

  @override
  _AdvanceSearchState createState() => _AdvanceSearchState();
}

class _AdvanceSearchState extends State<AdvanceSearch> {
   final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();
  int carMaker = 1000000;
  int carClass = 0;
  String type = '5';
  String price = 'All';
  String from = 'All';
  String to = 'All';
  String city = 'All';
  List<FiealdSearch<int>> carClases = [FiealdSearch("Car class", 0)];
  List<FiealdSearch> getCarMake(List<CarMake> carmakes) {
    var _carMakes = carmakes.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
    _carMakes.add(FiealdSearch<int>('All', 1000000));
    return _carMakes;
  }

  void getCarClass(List<CarMake> carmakes) {
    if (carMaker == null)
      carClases = [FiealdSearch("Car class", 0)];
    else {
      var spesificCarMake =
          carmakes.firstWhere((element) => element.ID == carMaker);
      carClases =
          spesificCarMake.CarClasses.where((element) => element.NameEn != null)
              .map((e) => FiealdSearch(e.NameEn, e.ID))
              .toList();
      carClases.add(FiealdSearch<int>('All', 1000000));
      carClass = 1000000;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<CarMake> carmakes = (ModalRoute.of(context).settings.arguments
        as Map<String, List<CarMake>>)['carMaker'];
    final List<FiealdSearch> vehivalType = [
      FiealdSearch('All', 'All'),
      FiealdSearch('Hatchback', '5'),
      FiealdSearch('Coupe', '4'),
      FiealdSearch('SUV', '3'),
      FiealdSearch('Sedan', '2'),
      FiealdSearch('Cross over', '1')
    ];
    final List<FiealdSearch> City = [
      FiealdSearch('All', 'All'),
      FiealdSearch('Dubai', '2'),
    ];
    final List<FiealdSearch> Price = [
      FiealdSearch('Price', 'All'),
    ];
    final List<FiealdSearch> years = [
      FiealdSearch('From', 'All'),
      FiealdSearch('To', 'All'),
      FiealdSearch('2013', '2013'),
      FiealdSearch('2014', '2014'),
      FiealdSearch('2015', '2015'),
      FiealdSearch('2016', '2016'),
      FiealdSearch('2017', '2017'),
      FiealdSearch('2018', '2018'),
      FiealdSearch('2019', '2019'),
      FiealdSearch('2020', '2020'),
      FiealdSearch('2021', '2021'),
    ];
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
                Column(children: [
                  Padding(
                      padding: new EdgeInsets.all(8.0),
                      child: CustomAppBar(
                        text: S.of(context).advanceSearch,
                        icon: Icons.arrow_back_ios,
                        onPressed: () => Navigator.pop(context),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/Img/carSearchImag.png",
                            fit: BoxFit.fitWidth,
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 150,
                                child: CustomDropDown(
                                  selectedValue: carMaker,
                                  onChange:
                                      carmakes == null || carmakes.length == 0
                                          ? null
                                          : (int x) {
                                              setState(() {
                                                carMaker = x;
                                                getCarClass(carmakes);
                                              });
                                            },
                                  items: getCarMake(carmakes),
                                )),
                            VerLineDivider(),
                            Container(
                                width: 130,
                                child: CustomDropDown(
                                  selectedValue: carClass,
                                  onChange: CarClass == null
                                      ? null
                                      : (int x) {
                                          setState(() {
                                            carClass = x;
                                          });
                                        },
                                  items: carClases,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorzLineDivider(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 150,
                                child: CustomDropDown(
                                  selectedValue: type,
                                  onChange:
                                      carmakes == null || carmakes.length == 0
                                          ? null
                                          : (String x) {
                                              setState(() {
                                                type = x;
                                              });
                                            },
                                  items: vehivalType,
                                )),
                            VerLineDivider(),
                            //price
                            Container(
                                width: 130,
                                child: CustomDropDown(
                                  selectedValue: price,
                                  onChange: CarClass == null
                                      ? null
                                      : (String x) {
                                          setState(() {
                                            price = x;
                                          });
                                        },
                                  items: Price,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorzLineDivider(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: 150,
                                child: CustomDropDown<String>(
                                  selectedValue: from,
                                  onChange:
                                      carmakes == null || carmakes.length == 0
                                          ? null
                                          : (String x) {
                                              setState(() {
                                                from = x;
                                              });
                                            },
                                  items: years
                                      .where((element) => element.value != 'To')
                                      .toList(),
                                )),
                            VerLineDivider(),
                            Container(
                                width: 130,
                                child: CustomDropDown<String>(
                                  selectedValue: to,
                                  onChange:
                                      carmakes == null || carmakes.length == 0
                                          ? null
                                          : (String x) {
                                              setState(() {
                                                to = x;
                                              });
                                            },
                                  items: years
                                      .where(
                                          (element) => element.value != 'From')
                                      .toList(),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorzLineDivider(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 150,
                                child: CustomDropDown<String>(
                                  selectedValue: city,
                                  onChange:
                                      carmakes == null || carmakes.length == 0
                                          ? null
                                          : (String x) {
                                              setState(() {
                                                city = x;
                                              });
                                            },
                                  items: City,
                                )),
                          ],
                        ),
                        HorzLineDivider(
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ButtonTheme(
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            color: Color.fromARGB(200, 237, 56, 38),
                            child: Text(
                              "Search",
                              style: TextStyle(fontSize: 18),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                    color: Color.fromARGB(200, 237, 56, 38))),
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  CarSearch(carMaker, carClass, type, price,
                                      from, to, city));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )
                ])
              ])));
        })));
  }
}
