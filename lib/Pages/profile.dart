import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weajar/Pages/AddNewCar.dart';
import 'package:weajar/Pages/EditProfile.dart';
import 'package:weajar/Pages/weCarList.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/CarList.dart';
import 'package:weajar/components/HorzLineDivider.dart';
import 'package:weajar/components/Loader.dart';
import 'package:weajar/components/SideDrawer.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/model/CarMake.dart';
import 'package:weajar/model/LoginUser.dart';
import 'package:weajar/model/car.dart';
import 'package:weajar/service/AuthenticationService.dart';
import 'package:weajar/service/UserService.dart';
import 'package:weajar/service/carListservice.dart';
import 'package:weajar/service/itemFetcher.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';

import 'AdvanceSearch.dart';

class Profile extends StatefulWidget {
  static const String routeName = 'profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //it will hold search box value
  TextEditingController _searchQuery;
  List<FullCarInfo> filteredRecored;
  final _carList = <FullCarInfo>[];
  bool _isLoading = true;
  final _itemFetcher = ItemFetcher();
  final _carMakerFetcher = CarMakeFetcher();
  final _userService = UserService();
  List<Future> requests;
  List<Car> _cars;
  LoginUser currentUser;
  List<CarMake> _carsMakers;
  var auth = AuthenticationService();
  void _loadMore() {
    _isLoading = true;
    requests = List();
    requests.add(_itemFetcher.fetchCarByUser());
    requests.add(_carMakerFetcher.fetchCarMaker());
    Future.wait(requests).then((List<dynamic> nums) async {
      if (currentUser == null) {
        currentUser =  auth.getCurrentUser();
      }
      _cars = nums[0];
      if (_cars == null) {
        await auth.signOut();
        Navigator.pushNamedAndRemoveUntil(
            context, WeCarList.routeName, (route) => false);
        return;
      }
      _carsMakers = nums[1];
      if (_cars.isEmpty) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;

          var carsInfo = _cars.map((e) {
            var carMake =
                _carsMakers.firstWhere((element) => element.ID == e.CarMakeID);
            return FullCarInfo(
                CarImages: List<CarImage>.from(e.CarImages).toList(),
                CarClass: carMake.CarClasses.firstWhere(
                    (element) => element.ID == e.CarClassID).NameEn,
                CarMake: carMake.NameEn,
                Model: e.Model,
                DrivingLicense: e.DrivingLicense,
                MinimumAge: e.MinimumAge,
                InsuranceType: e.InsuranceType,
                InsuranceAmount: e.InsuranceAmount,
                Seats:  e.Seats,
                Status: e.Status,
                WithDelivery: e.WithDelivery,
                IsPrime: e.IsPrime ?? false,
                Price: e.Price);
          }).toList();
          _carList.addAll(carsInfo);
          filteredRecored.addAll(carsInfo);
        });
      }
    });
  }

  //It'll update list items atfer searching complete.
  void updateSearchQuery(String newQuery) {
    filteredRecored.clear();
    if (newQuery.length > 0) {
      Set<FullCarInfo> set = Set.from(_carList);
      set.forEach((element) => filterList(element, newQuery));
    }
    if (newQuery.isEmpty) {
      filteredRecored.addAll(_carList);
    }
    setState(() {});
  } //Filtering the list item with found match string.

  filterList(FullCarInfo car, String searchQuery) {
    setState(() {
      if ('${car.CarMake}'.toLowerCase().contains(searchQuery)) {
        filteredRecored.add(car);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    filteredRecored = List();
    _searchQuery = new TextEditingController();
    try {
      _loadMore();
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final newLocale = Localizations.localeOf(context);
    var mainWidth = MediaQuery.of(context).size.width;
    var mainHeigh = MediaQuery.of(context).size.height;
    bool showPremium = false;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[800],
        drawer: SideDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        }, child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight,
                width: MediaQuery.of(context).size.width,
                child: _isLoading
                    ? Loader()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (!_isLoading)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: new EdgeInsets.all(8.0),
                                  child: CustomAppBar(
                                      text: S.of(context).profile,
                                      icon: Icons.menu,
                                      onPressed: () {
                                        if (scaffoldKey.currentState.hasDrawer)
                                          scaffoldKey.currentState.openDrawer();
                                      }),
                                ),
                                HorzLineDivider(
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: mainWidth * 0.1,
                                        ),
                                        Text(
                                          S.of(context).greeting(
                                              currentUser?.Name ?? ""),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () async {
                                            if (auth.IsTokenNotActive())
                                              auth.signOut();
                                            await Navigator.pushNamed(
                                                context, EditProfile.routeName);
                                            if (( auth.getCurrentUser())
                                                .chnaged) {
                                              var result = await _userService
                                                  .updateUser();
                                              if (!result) {
                                                auth.signOut();
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    RaisedButton(
                                      onPressed: () async {
                                        var result = await Navigator.of(context)
                                            .pushNamed(AddEditCar.routeName,
                                                arguments: {
                                              'carMaker': _carsMakers
                                            });
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        if (result != null) {
                                          var success = await _itemFetcher.AddCar(result);
                                          if(!success){
                                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Something went wrong"),));
                                          }
                                        }
                                        setState(() {
                                          _loadMore();
                                        });
                                      },
                                      color: Color.fromARGB(250, 237, 56, 38),
                                      child: Text(
                                        S.of(context).newCar,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  200, 237, 56, 38))),
                                    )
                                  ],
                                ),
                                HorzLineDivider(
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(8, 20, 8, 30),
                                    child: Container(
                                      height: 68,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 8,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1, vertical: 1),
                                        child: TextField(
                                          controller: _searchQuery,
                                          onChanged: updateSearchQuery,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            hintText: 'Search Contacts',
                                            prefixIcon: Icon(Icons.search),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                          ),
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: Text(
                                      "My cars",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ))
                              ],
                            ),
                          filteredRecored != null && filteredRecored.length > 0
                              ? Expanded(
                                  child: CarList(carList: filteredRecored))
                              : (_carList == null || _isLoading)
                                  ? Center(
                                      child: Loader(),
                                    )
                                  : Center(
                                      child: new Text(S.of(context).noMatch),
                                    )
                        ],
                      ),
              );
            },
          ),
        )));
  }
}
