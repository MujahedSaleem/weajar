import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weajar/Repo.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/CustomDropDown.dart';
import 'package:weajar/components/ImageViewer.dart';
import 'package:weajar/components/Loader.dart';
import 'package:weajar/components/SideDrawer.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/model/CarMake.dart';
import 'package:weajar/model/Isearch.dart';
import 'package:weajar/model/car.dart';
import 'package:weajar/service/CitiesFetcher.dart';
import 'package:weajar/service/itemFetcher.dart';
import 'package:mime_type/mime_type.dart';

class AddEditCar extends StatefulWidget {
  static const String routeName = "addeditcar";
  @override
  _AddEditCarState createState() => _AddEditCarState();
}

class _AddEditCarState extends State<AddEditCar> {
  final _cityFetcher = CitiesFetcher();
  final _itemFetcher = ItemFetcher();

  var repo = Repo();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String base64Image;
  List<File> tempImage = new List();
  String errMessage = 'Error Uploading Image';
  int carMaker ;
  int carClass = 0;
  String type = '5';
  String price = 'All';
  String model = '2013';
  bool deliveryAvailability = true;
  String drivingLicences = 'LocalDrivingLicense';
  String insuranceTypeVal = 'FullInsurance';
  bool adTypeValue = false;
  int city = 0;
  int status = 0;

  bool _isloading = true;
  TextEditingController _priceControlelr;
  TextEditingController _ageControlelr;
  TextEditingController _depositControlelr;
  List<FiealdSearch<int>> Cities;
  List<FiealdSearch<int>> carClases = [FiealdSearch("Car class", 0)];
  final List<FiealdSearch> carStatus = [
    FiealdSearch(' Available ', 0),
    FiealdSearch('Booked', 1)
  ];
  final List<FiealdSearch> insuranceType = [
    FiealdSearch('Full insurance', 'FullInsurance'),
    FiealdSearch('Third party insurance', 'ThirdPartyInsurance')
  ];
  final List<FiealdSearch> availability = [
    FiealdSearch('Yes', true),
    FiealdSearch('No', false)
  ];
  final List<FiealdSearch> adType = [
    FiealdSearch('Premium', true),
    FiealdSearch('Normal', false)
  ];
  final List<FiealdSearch> drivingLicencesStates = [
    FiealdSearch('Local driving license', 'LocalDrivingLicense'),
    FiealdSearch(
        'International driving license', 'InternationalDrivingLicense'),
    FiealdSearch('No specific type is required', 'SpecificTypeIsNotRequired')
  ];
  final List<FiealdSearch> years = [
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
  final List<FiealdSearch> vehivalType = [
    FiealdSearch('Hatchback', '5'),
    FiealdSearch('Coupe', '4'),
    FiealdSearch('SUV', '3'),
    FiealdSearch('Sedan', '2'),
    FiealdSearch('Cross over', '1')
  ];
  List<FiealdSearch> getCarMake(List<CarMake> carmakes) {
    var _carMakes = carmakes.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
    if(carMaker == null)
    carMaker = _carMakes[0].Key;
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
      carClass = carClases[0].Key;
    }
  }

  @override
  void initState() {
    super.initState();
    _priceControlelr = new TextEditingController();
    _ageControlelr = new TextEditingController();
    _depositControlelr = new TextEditingController();
    tempImage.add(null);
    tempImage.add(null);
    tempImage.add(null);
    tempImage.add(null);
    tempImage.add(null);
    _cityFetcher.fetchCities().then((value)  async {
      if (repo.fullCarInfo == null)
      repo.fullCarInfo = await _itemFetcher.fetchCars();

      Cities = value.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
      if (city == 0) city = Cities[0].Key;
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<CarMake> carmakes = (ModalRoute.of(context).settings.arguments
        as Map<String, List<CarMake>>)['carMaker'];   
    final List<Car> carList = repo.fullCarInfo;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(250, 32, 37, 42),
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
            child: SingleChildScrollView(
                child: _isloading
                    ? Loader()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Padding(
                                padding: new EdgeInsets.all(8.0),
                                child: CustomAppBar(
                                    text: S.of(context).newCar,
                                    icon: Icons.arrow_back_ios,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })),
                            ImageViewr(
                              tempImage,
                              setStateMain: this.setState,
                              index: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 1,
                                ),
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 2,
                                ),
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 3,
                                ),
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              color: Color.fromARGB(200, 61, 67, 74),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        S.of(context).cardetails,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: carMaker,
                                          onChange: carmakes == null ||
                                                  carmakes.length == 0
                                              ? null
                                              : (int x) {
                                                  setState(() {
                                                    carMaker = x;
                                                    getCarClass(carmakes);
                                                  });
                                                },
                                          items: getCarMake(carmakes),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
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
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown<String>(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: model,
                                          onChange: carmakes == null ||
                                                  carmakes.length == 0
                                              ? null
                                              : (String x) {
                                                  setState(() {
                                                    model = x;
                                                  });
                                                },
                                          items: years,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: type,
                                          onChange: carmakes == null ||
                                                  carmakes.length == 0
                                              ? null
                                              : (String x) {
                                                  setState(() {
                                                    type = x;
                                                  });
                                                },
                                          items: vehivalType,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: TextField(
                                              controller: _priceControlelr,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: S.of(context).price,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20.0, 15.0, 20.0, 15.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: city,
                                          onChange: CarClass == null
                                              ? null
                                              : (int x) {
                                                  setState(() {
                                                    city = x;
                                                  });
                                                },
                                          items: Cities,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: status,
                                          onChange: CarClass == null
                                              ? null
                                              : (int x) {
                                                  setState(() {
                                                    status = x;
                                                  });
                                                },
                                          items: carStatus,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: deliveryAvailability,
                                          onChange: CarClass == null
                                              ? null
                                              : (bool x) {
                                                  setState(() {
                                                    deliveryAvailability = x;
                                                  });
                                                },
                                          items: availability,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: TextField(
                                              controller: _ageControlelr,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: S.of(context).age,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20.0, 15.0, 20.0, 15.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                              ),
                                            )),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: drivingLicences,
                                          onChange: CarClass == null
                                              ? null
                                              : (String x) {
                                                  setState(() {
                                                    drivingLicences = x;
                                                  });
                                                },
                                          items: drivingLicencesStates,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: insuranceTypeVal,
                                          onChange: CarClass == null
                                              ? null
                                              : (String x) {
                                                  setState(() {
                                                    insuranceTypeVal = x;
                                                  });
                                                },
                                          items: insuranceType,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: TextField(
                                              controller: _depositControlelr,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: S.of(context).deposit,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20.0, 15.0, 20.0, 15.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                              ),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomDropDown(
                                          color: Colors.white,
                                          radius: BorderRadius.circular(20),
                                          selectedValue: adTypeValue,
                                          onChange: CarClass == null
                                              ? null
                                              : (bool x) {
                                                  setState(() {
                                                    adTypeValue = x;
                                                  });
                                                },
                                          items: adType,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              onPressed: () {
                                if(_priceControlelr.value.text.trim() == '' || _ageControlelr.value.text.trim() == '' || _depositControlelr.value.text.trim() ==''||carClass == 0){
                                  Fluttertoast.showToast(
                                      msg: 'There is an empty field',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return ;
                                }
                                var searchForCar = carList.where((element) => element.CarClassID == carClass&&element.CarMakeID == carMaker);
                                if (searchForCar.length == 0){
                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("No Enough data for this car in database"),action: SnackBarAction(onPressed:()=>Navigator.pop(context) ,label: "ok",),));

                                  ;
                                return;
                                }
                                var carFormCarList = searchForCar.first;
                                var car = Car(
                                  CarMakeID:carMaker,
                                  CarClassID:carClass,
                                  CarImages: tempImage.where((element) => element!=null).map((e)  {
                                    var filePath = tempImage[0].path.split('/');
                                    var fileName = filePath[filePath.length-1];

                                    return CarImage(ImageStatus: 1,ImageURL:'data:${mime(fileName)};base64,'+base64Encode(e.readAsBytesSync()));

                                  }).toList(),
                                  Model:int.parse(model),
                                  Price:double.parse(_priceControlelr.value.text.trim()),
                                  CityID:city,
                                  Status:status,
                                  MinimumAge:int.parse(_ageControlelr.value.text.trim()),
                                  DrivingLicense:drivingLicences,
                                  WithDelivery:deliveryAvailability ,
                                  InsuranceAmount:double.parse(_depositControlelr.value.text.trim()),
                                  InsuranceType:insuranceTypeVal,
                                  Seats: carFormCarList.Seats,
                                  IsPrime:adTypeValue,);
                                if (car!=null)
                                Navigator.pop(context,car);
                                else
                                  Navigator.pop(context);
                              },
                              color: Color.fromARGB(250, 249, 26, 108),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  S.of(context).submit,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color:
                                          Color.fromARGB(250, 249, 26, 108))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ])));
      }))),
    );
  }
}
