import 'dart:math';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:weajar/model/car.dart';
import 'package:weajar/service/AuthenticationService.dart';

final _baseUrl = "https://api.weajar.com/Cars";

class ItemFetcher {
  Client client = Client();
  AuthenticationService auth = AuthenticationService();
  final _count = 103;
  final _itemsPerPage = 5;
  int _currentPage = 0;

  // This async function simulates fetching results from Internet, etc.
  Future<List<Car>> fetchCars() async {
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json'
    };
    final list = <Car>[];
    // Uncomment the following line to see in real time now items are loaded lazily.
    // print('Now on page $_currentPage');
    var data = await client.post("$_baseUrl/GetCars", headers: header);
    var cars = json.decode(data.body);
    List<Car> listx =
    List.from(cars["Data"]).map((e) => Car.fromJson(e)).toList();
    list.addAll(listx);
    return list;
  }

  // This async function simulates fetching results from Internet, etc.
  Future<List<Car>> fetchActiveCar() async {
    final list = <Car>[];
    final n = min(_itemsPerPage, _count - _currentPage * _itemsPerPage);
    // Uncomment the following line to see in real time now items are loaded lazily.
    // print('Now on page $_currentPage');
    var data = await client.post("$_baseUrl/GetActiveCars");
    var cars = json.decode(data.body);
    List<Car> listx =
    List.from(cars["Data"]).map((e) => Car.fromJson(e)).toList();
    list.addAll(listx);
    _currentPage++;
    return list;
  }

  Future AddCar(Car car) async {
    var header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json'
    };

    var result = await client.post("$_baseUrl/Create",
        body: car.toJsonString(), headers: header);
    if (result.statusCode == 200) return true;
    return false;
  }

  Future<List<Car>> fetchCarByUser() async {
    final list = <Car>[];

    var header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json'
    };
    var data = await client.post("$_baseUrl/getCarsByUser", headers: header);
    if (data.statusCode > 400 && data.statusCode < 500) {
      return null;
    }
    var cars = json.decode(data.body);
    List<Car> listx =
    List.from(cars["Data"]).map((e) => Car.fromJson(e)).toList();
    list.addAll(listx);
    return list;
  }

  DeleteCar(int carID, int userId) async {
    var header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json',
      'UserID': '$userId'
    };

    var result =
    await client.post(
        "$_baseUrl/Delete?id=$carID", headers: header);
    if (result.statusCode == 200) return true;
    return false;
  }

  Future UpdateCar(Car car) async {
    var header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json'
    };

    var result = await client.post("$_baseUrl/Update",
        body: car.toJsonString(), headers: header);
    if (result.statusCode == 200) return Car.fromJson(JsonDecoder().convert(result.body)["Data"]);
    return false;
  }
}
