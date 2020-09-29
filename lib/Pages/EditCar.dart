import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
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
import 'package:weajar/service/AuthenticationService.dart';
import 'package:weajar/service/CitiesFetcher.dart';
import 'package:weajar/service/itemFetcher.dart';
import 'package:mime_type/mime_type.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';

class EditCar extends StatefulWidget {
  static const String routeName = "EditCar";
  @override
  _EditCarState createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  final _cityFetcher = CitiesFetcher();

  var repo = Repo();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String base64Image;
  List<File> tempImage = new List();
  String errMessage = 'Error Uploading Image';
  int carMaker ;
  int carClass ;
  int type = 5;
  String price = 'All';
  String model = '2013';
  bool deliveryAvailability = true;
  String drivingLicences = 'LocalDrivingLicense';
  String insuranceTypeVal = 'FullInsurance';
  bool adTypeValue = false;
  int city = 0;
  int status = 1;
  var currentUser = AuthenticationService().getCurrentUser();
  bool _isloading = true;
  List<FiealdSearch> _carsMakers;
  TextEditingController _priceControlelr;
  TextEditingController _ageControlelr;
  TextEditingController _depositControlelr;
  List<FiealdSearch<int>> Cities;
  List<FiealdSearch<int>> carClases = [FiealdSearch("Class", 0)];
List<String> networkImages;




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
    FiealdSearch('Hatchback', 5),
    FiealdSearch('Coupe', 4),
    FiealdSearch('SUV', 3),
    FiealdSearch('Sedan', 2),
    FiealdSearch('Cross over', 1)
  ];
   getCarMake(List<CarMake> carmakes) {
     _carsMakers = carmakes.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();

    setState(() {
      carMaker= _carsMakers[0].Key;
    });
  }

  void getCarClass(List<CarMake> carmakes) {

      var spesificCarMake =
          carmakes.firstWhere((element) => element.ID == carMaker);
      carClases =
          spesificCarMake.CarClasses.where((element) => element.NameEn != null)
              .map((e) => FiealdSearch(e.NameEn, e.ID))
              .toList();
      setState(() {
        if (carMaker == 0) {
          carClass = 0;
        } else {
          carClass = carClases[0].Key;
        }
      });


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
    if (repo.allCity == null || repo.allCity.length == 0) {
      _cityFetcher.fetchCities().then((value) async {
        setState(() {
          Cities = value.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
          Cities.insert(0, FiealdSearch('City', 0));
        });
        repo.allCity = value.toList();
      });
    } else {
      setState(() {
        Cities = repo.allCity.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
        Cities.insert(0, FiealdSearch('City', 0));
      });
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<CarMake> carmakes = (ModalRoute.of(context).settings.arguments
        as Map<String,dynamic>)['carMaker'];
    final Car carforEdit = (ModalRoute.of(context).settings.arguments
   as  Map<String,dynamic> )['car'];
    if(carMaker == null){
    getCarMake(carmakes);
    carMaker = _carsMakers.where((e) => e.Key == carforEdit.CarMakeID).first.Key;
    getCarClass(carmakes);
    carClass = carClases.where((e) => e.Key == carforEdit.CarClassID).first.Key;
    model = "${carforEdit.Model}";
    _priceControlelr.text = "${carforEdit.Price}";
    city = Cities.firstWhere((e) => e.Key == carforEdit.CityID).Key;
    status = carforEdit.Status;
    _ageControlelr.text = "${carforEdit.MinimumAge}";
    drivingLicences = carforEdit.DrivingLicense;
    deliveryAvailability = carforEdit.WithDelivery;
    _depositControlelr.text = "${carforEdit.InsuranceAmount}";
    insuranceTypeVal = carforEdit.InsuranceType;
    type = carforEdit.Seats;
    adTypeValue = carforEdit.IsPrime;
    networkImages = carforEdit.CarImages.map((e) => 'https://api.weajar.com/img${e.ImageURL}').toList();
    if (networkImages.length <5){
      var _length = networkImages.length;
      for(int i =0;i< 5- _length;i++ ){
        networkImages.add(null);
      }
    }
    }

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
                                    iconColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })),
                            ImageViewr(
                              tempImage,
                              setStateMain: this.setState,
                              index: 0,
                              text: S.of(context).cover,
                              height: 100,
                              width: 100,
                              netWorkImag: networkImages,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 1,
                                  netWorkImag: networkImages,

                                ),
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 2,
                                  netWorkImag: networkImages,

                                ),
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 3,
                                  netWorkImag: networkImages,

                                ),
                                ImageViewr(
                                  tempImage,
                                  setStateMain: this.setState,
                                  index: 4,
                                  netWorkImag: networkImages,

                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 565,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(200, 61, 67, 74),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).cardetails,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomDropDown(
                                              label: S.of(context).carMake,
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
                                              items: _carsMakers,
                                            ),
                                            CustomDropDown(
                                              label: S.of(context).carclass,
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
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomDropDown<String>(
                                                label: S.of(context).model,
                                                color: Colors.white,
                                                radius:
                                                    BorderRadius.circular(20),
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
                                              CustomDropDown(
                                                label: S.of(context).type,
                                                color: Colors.white,
                                                radius:
                                                    BorderRadius.circular(20),
                                                selectedValue: type,
                                                onChange: carmakes == null ||
                                                        carmakes.length == 0
                                                    ? null
                                                    : (int x) {
                                                        setState(() {
                                                          type = x;
                                                        });
                                                      },
                                                items: vehivalType,
                                              )
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                  width: 127,

                                                  height: 55,

                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white),
                                                  child: TextField(
                                                    controller:
                                                        _priceControlelr,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      hintText:
                                                          S.of(context).price,

                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0)),
                                                    ),
                                                  )),
                                              CustomDropDown(
                                                label: S.of(context).city,
                                                color: Colors.white,
                                                radius:
                                                    BorderRadius.circular(20),
                                                selectedValue: city,
                                                onChange: CarClass == null
                                                    ? null
                                                    : (int x) {
                                                        setState(() {
                                                          city = x;
                                                        });
                                                      },
                                                items: Cities,
                                              )
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomDropDown(
                                                label: S.of(context).status,
                                                color: Colors.white,
                                                radius:
                                                    BorderRadius.circular(20),
                                                selectedValue: status,
                                                onChange: (int x) {
                                                  setState(() {
                                                    status = x;
                                                  });
                                                },
                                                items: getcarStatus(context),
                                              ),
                                              CustomDropDown(
                                                label: S
                                                    .of(context)
                                                    .deliveryToYouLcation,
                                                color: Colors.white,
                                                radius:
                                                    BorderRadius.circular(20),
                                                selectedValue:
                                                    deliveryAvailability,
                                                onChange: CarClass == null
                                                    ? null
                                                    : (bool x) {
                                                        setState(() {
                                                          deliveryAvailability =
                                                              x;
                                                        });
                                                      },
                                                items: getavailability(context),
                                              )
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                  width: 127,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white),
                                                  child: TextField(
                                                    controller: _ageControlelr,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(

                                                      fillColor: Colors.white,
                                                      hintText:
                                                          S.of(context).age,

                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0)),
                                                    ),
                                                  )),
                                              CustomDropDown(
                                                label:
                                                    S.of(context).drivinglicens,
                                                color: Colors.white,
                                                radius:
                                                    BorderRadius.circular(20),
                                                selectedValue: drivingLicences,
                                                onChange: (String x) {
                                                  setState(() {
                                                    drivingLicences = x;
                                                  });
                                                },
                                                items: getdrivingLicencesStates(context),
                                              )
                                            ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomDropDown(
                                                label: S.of(context).incType,
                                                color: Colors.white,
                                                radius:
                                                    BorderRadius.circular(20),
                                                selectedValue: insuranceTypeVal,
                                                onChange: CarClass == null
                                                    ? null
                                                    : (String x) {
                                                        setState(() {
                                                          insuranceTypeVal = x;
                                                        });
                                                      },
                                                items: getinsuranceType(context),
                                              ),
                                              Container(
                                                  width: 127,
                                                  height: 55,

                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white),
                                                  child: TextField(
                                                    controller:
                                                        _depositControlelr,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      hintText:
                                                          S.of(context).deposit,

                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0)),
                                                    ),
                                                  ))
                                            ]),
                                        if (currentUser.IsAdmin)
                                          SizedBox(
                                            height: 10,
                                          ),
                                        if (currentUser.IsAdmin)
                                          CustomDropDown(
                                            label: S.of(context).carrenttype,
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
                                            items: getadType(context),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(

                              onPressed: () {
                                if (_priceControlelr.value.text.trim() == '' ||
                                    _ageControlelr.value.text.trim() == '' ||
                                    _depositControlelr.value.text.trim() ==
                                        '' ||
                                    city == 0||
                                    carClass == 0 ||
                                    carMaker == 0) {
                                  Fluttertoast.showToast(
                                      msg: 'There is an empty field',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                var carImages = List<CarImage>();
                                for(int i=0;i<networkImages.length;i++){
                                  if(networkImages[i] != null && networkImages[i]!="delete"){
                                    var carImage = carforEdit.CarImages[i];
                                    carImages.add(carImage);
                                  }else if (networkImages[i]=="delete"){
                                    var carImage = carforEdit.CarImages[i];
                                    carImage.ImageStatus = 2;
                                    carImages.add(carImage);

                                  }
                                }
                                var paths = tempImage.where((element) => element!=null).toList();
                               if( paths.length >0 ){
                                var filePath = paths.first.path?.split('/');

                                carImages.addAll(tempImage
                                    .where((element) => element != null)
                                    .map((e) {
                                  var fileName =
                                  filePath[filePath.length - 1];

                                  return CarImage(
                                    CarID: carforEdit.ID,
                                      ImageStatus: 1,
                                      ImageURL:
                                      'data:${mime(fileName)};base64,' +
                                          base64Encode(
                                              e.readAsBytesSync()));
                                }).toList());
}
                                var car = Car(
                                  CarMakeID: carMaker,
                                  CarClassID: carClass,
                                  CarImages: carImages ,
                                  Model: int.parse(model),
                                  ID: carforEdit.ID,
                                  Price: double.parse(
                                      _priceControlelr.value.text.trim()),
                                  CityID: city,
                                  Status: status,
                                  UserID: currentUser.ID,
                                  MinimumAge: int.parse(
                                      _ageControlelr.value.text.trim()),
                                  DrivingLicense: drivingLicences,
                                  WithDelivery: deliveryAvailability,
                                  InsuranceAmount: double.parse(
                                      _depositControlelr.value.text.trim()),
                                  InsuranceType: insuranceTypeVal,
                                  Seats: type,
                                  IsPrime: adTypeValue,
                                );
                                if (car != null)
                                  Navigator.pop(context, car);
                                else
                                  Navigator.pop(context);
                              },
                              color: Color(0xFF14B1CE),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  S.of(context).save,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Color(0xFF14B1CE))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ])));
      }))),
    );
  }

  getinsuranceType(BuildContext context) {
       final List<FiealdSearch> insuranceType = [
       FiealdSearch(S.of(context).full, 'FullInsurance'),
       FiealdSearch(S.of(context).third, 'ThirdPartyInsurance')
     ];
       return insuranceType;
  }

  getavailability(BuildContext context) {
    final List<FiealdSearch> availability = [
      FiealdSearch(S.of(context).yes, true),
      FiealdSearch(S.of(context).no, false)
    ];
    return availability;
  }

  getcarStatus(BuildContext context) {
    final List<FiealdSearch> carStatus = [
      FiealdSearch(S.of(context).available, 1),
      FiealdSearch(S.of(context).booked, 0)
    ];
    return carStatus;
  }

  getdrivingLicencesStates(BuildContext context) {
    final List<FiealdSearch> drivingLicencesStates = [
      FiealdSearch(S.of(context).local, 'LocalDrivingLicense'),
      FiealdSearch(S.of(context).International, 'InternationalDrivingLicense'),
      FiealdSearch(S.of(context).SpecificType, 'SpecificTypeIsNotRequired')
    ];
    return drivingLicencesStates;
  }

  getadType(BuildContext context) {
    final List<FiealdSearch> adType = [
      FiealdSearch(S.of(context).premium, true),
      FiealdSearch(S.of(context).normal, false)
    ];
    return adType;
  }
}
