import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weajar/Repo.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/CustomDropDown.dart';
import 'package:weajar/components/HorzLineDivider.dart';
import 'package:weajar/components/VerLineDivider.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/model/CarMake.dart';
import 'package:weajar/model/Isearch.dart';
import 'package:weajar/model/carSearch.dart';
import 'package:weajar/service/CitiesFetcher.dart';

class AdvanceSearch extends StatefulWidget {
  static const String routeName = "AdvanceSearch";

  @override
  _AdvanceSearchState createState() => _AdvanceSearchState();
}

class _AdvanceSearchState extends State<AdvanceSearch> {
  final _cityFetcher = CitiesFetcher();
  var repo = Repo();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int carMaker ;
  int carClass = 0;
  String type = '0';
  String price = 'null';
  String from = 'All';
  String to = 'All';
  int city = 0;
  int sort = 5;
  List<FiealdSearch<int>> carClases = [];
  List<FiealdSearch<int>> Cities = [];
  List<FiealdSearch> _carsMakers;
  List<FiealdSearch> SortList;

  getCarMake(List<CarMake> carmakes) {
    _carsMakers = carmakes.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
    _carsMakers.insert(0, FiealdSearch<int>(S.of(this.context).all, 0));
    if (carMaker == null)
      setState(() {
        carMaker = _carsMakers[0].Key;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (repo.allCity == null || repo.allCity.length == 0) {
      _cityFetcher.fetchCities().then((value) async {
        setState(() {
          Cities = value.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
        });

        repo.allCity = value.toList();
      });
    } else {
      setState(() {
        Cities = repo.allCity.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
      });
    }

  }

  void getCarClass(List<CarMake> carmakes) {
    if (carMaker == 0) {
      setState(() {
        carClases = [];
        carClases.insert(0, FiealdSearch<int>(S.of(this.context).all, 0));
        carClass = 0;
      });
    }else{
      var spesificCarMake =
      carmakes.firstWhere((element) => element.ID == carMaker);
      carClases =
          spesificCarMake.CarClasses.where((element) => element.NameEn != null)
              .map((e) => FiealdSearch(e.NameEn, e.ID))
              .toList();
      carClases.insert(0, FiealdSearch<int>(S.of(this.context).all, 0));
      setState(() {
        if (carMaker == 0) {
          carClass = 0;
        } else {
          carClass = carClases[0].Key;
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final List<CarMake> carmakes = (ModalRoute.of(context).settings.arguments
        as Map<String, List<CarMake>>)['carMaker'];
    if(carMaker == null){
      getCarMake(carmakes);
      getCarClass(carmakes);
    }
    SortList = [
      FiealdSearch('${S.of(context).price} ${S.of(context).acs}',0),
      FiealdSearch('${S.of(context).price} ${S.of(context).desc}',1),
      FiealdSearch('${S.of(context).date} ${S.of(context).acs}',2),
      FiealdSearch('${S.of(context).date} ${S.of(context).desc}',3),
      FiealdSearch('${S.of(context).model} ${S.of(context).acs}',4),
      FiealdSearch('${S.of(context).model} ${S.of(context).desc}',5),
    ];
    if(Cities != null && Cities[0].Key != 0)
    Cities.insert(0, FiealdSearch(S.of(this.context).all, 0));



    final List<FiealdSearch> vehivalType = [
      FiealdSearch(S.of(context).all, '0'),
      FiealdSearch('Hatchback', '5'),
      FiealdSearch('Coupe', '4'),
      FiealdSearch('SUV', '3'),
      FiealdSearch('Sedan', '2'),
      FiealdSearch('Cross over', '1')
    ];
    final List<FiealdSearch> Price = [
      FiealdSearch(S.of(context).all, 'null'),
      FiealdSearch('50 - 1000', '{"fromVal":50,"toVal":1000}'),
      FiealdSearch('1000 - 2000', '{"fromVal":1000,"toVal":2000}'),
      FiealdSearch('2000 - 3000', '{"fromVal":2000,"toVal":3000}'),
      FiealdSearch('3000 - 4000', '{"fromVal":3000,"toVal":4000}'),
      FiealdSearch('4000 - 5000', '{"fromVal":4000,"toVal":5000}'),
      FiealdSearch('5000 - 6000', '{"fromVal":5000,"toVal":6000}'),
      FiealdSearch('6000 - 7000', '{"fromVal":6000,"toVal":7000}'),
      FiealdSearch('7000 - 8000', '{"fromVal":7000,"toVal":8000}'),
      FiealdSearch('8000 - 9000', '{"fromVal":8000,"toVal":9000}'),
      FiealdSearch('9000 - 10000', '{"fromVal":9000,"toVal":10000}'),
      FiealdSearch('10000', '{"fromVal":10000,"toVal":11000}'),
    ];
    final List<FiealdSearch> years = [
      FiealdSearch(S.of(context).from, 'All'),
      FiealdSearch(S.of(context).to, 'All'),
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
        backgroundColor: Color(0xFF48484A),
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
                        iconColor: Colors.white,
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
                            CustomDropDown(
                              label: S.of(context).carMake,
                              hight: 55,
                              color: Colors.white,
                              radius: BorderRadius.circular(20),
                              selectedValue: carMaker,
                              onChange: carmakes == null || carmakes.length == 0
                                  ? null
                                  : (int x) {
                                      setState(() {
                                        carMaker = x;
                                        getCarClass(carmakes);
                                      });
                                    },
                              items: _carsMakers,
                            ),
                            VerLineDivider(),
                            CustomDropDown(
                              label: S.of(context).carclass,
                              color: Colors.white,
                              hight: 55,
                              radius: BorderRadius.circular(20),
                              selectedValue: carClass,
                              onChange: CarClass == null
                                  ? null
                                  : (int x) {
                                      setState(() {
                                        carClass = x;
                                      });
                                    },
                              items: carClases,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorzLineDivider(
                          color: Colors.grey[100],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomDropDown(
                              label: S.of(context).type,
                              hight: 55,
                              color: Colors.white,
                              radius: BorderRadius.circular(20),
                              selectedValue: type,
                              onChange: (String x) {
                                setState(() {
                                  type = x;
                                });
                              },
                              items: vehivalType,
                            ),
                            VerLineDivider(),
                            //price
                            CustomDropDown<String>(
                              hight: 55,
                              label: S.of(context).price,
                              color: Colors.white,
                              radius: BorderRadius.circular(20),
                              selectedValue: price,
                              onChange: carmakes == null || carmakes.length == 0
                                  ? null
                                  : (String x) {
                                      setState(() {
                                        price = x;
                                      });
                                    },
                              items: Price,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorzLineDivider(color: Colors.grey[100]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomDropDown<String>(
                              hight: 55,
                              label: S.of(context).model,
                              color: Colors.white,
                              radius: BorderRadius.circular(20),
                              selectedValue: from,
                              onChange: carmakes == null || carmakes.length == 0
                                  ? null
                                  : (String x) {
                                      setState(() {
                                        from = x;
                                      });
                                    },
                              items: years
                                  .where((element) =>
                                      element.value != S.of(context).to)
                                  .toList(),
                            ),
                            VerLineDivider(),
                            CustomDropDown<String>(
                              hight: 55,
                              label: S.of(context).model,
                              color: Colors.white,
                              radius: BorderRadius.circular(20),
                              selectedValue: to,
                              onChange: carmakes == null || carmakes.length == 0
                                  ? null
                                  : (String x) {
                                      setState(() {
                                        to = x;
                                      });
                                    },
                              items: years
                                  .where((element) =>
                                      element.value != S.of(context).from)
                                  .toList(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorzLineDivider(color: Colors.grey[100]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (Cities != null)
                      CustomDropDown(
                      label: S.of(context).city,
            hight: 55,
            color: Colors.white,
            radius: BorderRadius.circular(40),
            selectedValue: city,
            onChange: (int x) {
              setState(() {
                city = x;
              });
            },
            items: Cities,
          ),
                            VerLineDivider(),

                            CustomDropDown(
                            label: S.of(context).sort,
                            hight: 55,
                            color: Colors.white,
                            radius: BorderRadius.circular(40),
                            selectedValue: sort,
                            onChange: (int x) {
                            setState(() {
                            sort = x;
                            });
                            },
                            items: SortList,
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        HorzLineDivider(color: Colors.grey[100]),
                        SizedBox(
                          height: 50,
                        ),
                        ButtonTheme(
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            color: Color.fromARGB(200, 237, 56, 38),
                            child: Text(
                              S.of(context).search,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                    color: Color.fromARGB(200, 237, 56, 38))),
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  CarSearch(carMaker, carClass, type, price,
                                      from, to, city,sort));
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
