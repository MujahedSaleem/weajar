import 'dart:math';
import 'package:http/http.dart' show Client;
import 'package:weajar/model/City.dart';
import 'dart:convert';

import 'package:weajar/model/car.dart';

final _baseUrl = "https://api.weajar.com/City";

class CitiesFetcher {
  Client client = Client();



  // This async function simulates fetching results from Internet, etc.
  Future<List<City>> fetchCities() async {
    final list = <City>[];
    var data = await client.post("$_baseUrl/listCities");
    var rawCities = json.decode(data.body);
    List<City> cities =
    List.from(rawCities["Data"]).map((e) => City.fromJson(e)).toList();
    list.addAll(cities);
    return list;
  }
}
