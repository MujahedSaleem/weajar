import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weajar/Pages/AdvanceSearch.dart';
import 'package:weajar/Repo.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/CarList.dart';
import 'package:weajar/components/Loader.dart';
import 'package:weajar/components/SideDrawer.dart';
import 'package:weajar/model/CarMake.dart';
import 'package:weajar/model/car.dart';
import 'package:weajar/model/carSearch.dart';
import 'package:weajar/service/CitiesFetcher.dart';
import 'package:weajar/service/carListservice.dart';
import 'package:weajar/service/itemFetcher.dart';
import 'package:weajar/viewModels/FullCarInfo.dart';
import 'package:weajar/generated/l10n.dart';

// ignore: must_be_immutable
class WeCarList extends StatefulWidget {
  static const String routeName = 'weCarList';

  WeCarList({Key key}) : super(key: key);
  Locale _userLocale;
  @override
  _WeCarListState createState() => _WeCarListState();
}

class _WeCarListState extends State<WeCarList>
    with SingleTickerProviderStateMixin {
  //it will hold search box value
  Set<FullCarInfo> filteredRecored;
  var _carList = <FullCarInfo>[];
  bool _isLoading = true;
  final _itemFetcher = ItemFetcher();
  final _carMakerFetcher = CarMakeFetcher();
  final _cityFetcher = CitiesFetcher();

  var repo = Repo();
  List<Future> requests;
  List<Car> _cars;
  List<CarMake> _carsMakers;
  bool refresh = false;
  void _loadMore() {
    _isLoading = true;
    requests = List();
    requests.add(_itemFetcher.fetchActiveCar());
    requests.add(_carMakerFetcher.fetchCarMaker());
    requests.add(_cityFetcher.fetchCities());
    Future.wait(requests).then(( nums) {

      _cars = nums[0];
      filteredRecored = Set();
      _carList =List();
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
            var carClass =carMake.CarClasses.where(
                    (element) => element.ID == e.CarClassID);
            return FullCarInfo(
                CarImages: List<CarImage>.from(e.CarImages).toList(),
                CarClass: carClass.length>0?carClass.first.NameEn:null,
                CarMake: carMake.NameEn,
                Model: e.Model,
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
          }).toList();
          _carList.addAll(carsInfo);
          filteredRecored.addAll(carsInfo.toSet());
          refresh = false;
          repo.allCity =nums[2].toList() ;

        });
      }

    });
  }

  List<FullCarInfo> convertCarListToCarFullInfo(List<Car> cars) =>
      cars.map((e) {
        var carMake =
            _carsMakers.firstWhere((element) => element.ID == e.CarMakeID);
        return FullCarInfo(
            CarImages: List<CarImage>.from(e.CarImages).toList(),
            CarClass: e.CarClassID != null
                ? carMake.CarClasses.firstWhere(
                    (element) => element.ID == e.CarClassID).NameEn
                : '000',
            CarMake: carMake.NameEn,
            Model: e.Model,
            DrivingLicense: e.DrivingLicense,
            MinimumAge: e.MinimumAge,
            InsuranceType: e.InsuranceType,
            InsuranceAmount: e.InsuranceAmount,
            WithDelivery: e.WithDelivery,
            Seats: e.Seats,
            Status: e.Status,
            City: e.CityID,
            IsPrime: e.IsPrime ?? false,
            Price: e.Price);
      }).toList();
  //It'll update list items atfer searching complete.
  void updateSearchQuery(String newQuery) {
    filteredRecored.clear();
    if (newQuery.length > 0) {
      Set<FullCarInfo> set = Set.from(_carList);
      set.forEach((element) => filterList(element, newQuery));
    }
    if (newQuery.isEmpty) {
      filteredRecored.addAll(_carList.toSet());
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
    filteredRecored = Set();
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

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, AdvanceSearch.routeName,
        arguments: {'carMaker': _carsMakers}) as CarSearch;
    if (result != null) {
      var searchQueary = result;
      setState(() {
        filteredRecored = convertCarListToCarFullInfo(_cars
            .where((e) =>
        (searchQueary.city == 0 ||
            e.CityID == searchQueary.city) &&
                (searchQueary.carMaker == 0 ||
                    e.CarMakeID == searchQueary.carMaker) &&
                (searchQueary.carClass == null ||
                    searchQueary.carClass == 0 ||
                    e.CarClassID == searchQueary.carClass) &&
                ((searchQueary.from == 'All' ||
                        e.Model >= int.parse(searchQueary.from)) &&
                    (searchQueary.to == 'All' ||
                        e.Model <= int.parse(searchQueary.to))) &&
                (searchQueary.price == 'null' ||
                    e.Price >=
                            (JsonDecoder()
                                .convert(searchQueary.price)['fromVal']) &&
                        e.Price <=
                            (JsonDecoder()
                                .convert(searchQueary.price)['toVal'])))
            .toList()).toSet();
      });
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final newLocale = Localizations.localeOf(context);
    if (newLocale != widget._userLocale) {
      widget._userLocale = newLocale;
    }
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF48484A),
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
                    ? Loader(
                        color: refresh ? Color(0xFF48484A) : Colors.white,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (!_isLoading)
                            Column(
                              children: [
                                Padding(
                                  padding: new EdgeInsets.all(8.0),
                                  child: CustomAppBar(
                                    text: S.of(context).allOffers,
                                    icon: Icons.menu,
                                    iconColor: Colors.white,
                                    onPressed: () {
                                      if (scaffoldKey.currentState.hasDrawer)
                                        scaffoldKey.currentState.openDrawer();
                                    },
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () =>
                                        _navigateAndDisplaySelection(context),
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 0, 8, 30),
                                        child: Container(
                                          height: 68,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 8,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1, vertical: 1),
                                            child: TextField(
                                              onTap: () =>
                                                  _navigateAndDisplaySelection(
                                                      context),
                                              enabled: false,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: S.of(context).search,
                                                prefixIcon: Icon(Icons.search),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20.0, 15.0, 20.0, 15.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                              ),
                                            ),
                                          ),
                                        )))
                              ],
                            ),
                          filteredRecored != null && filteredRecored.length > 0
                              ? Expanded(
                                  child: CarList(
                                  carList: (filteredRecored.toList()),
                                  onRefresh: () async {
                                    setState(() {
                                      refresh = true;
                                      _loadMore();
                                      return;
                                    });
                                  },
                                ))
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
