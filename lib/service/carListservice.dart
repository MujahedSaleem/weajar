import 'dart:math';
import 'package:http/http.dart' show Client;
import 'package:weajar/model/CarMake.dart';
import 'dart:convert';

final _baseUrl = "https://api.weajar.com/CarMake";

class CarMakeFetcher {
  Client client = Client();

  final _count = 103;
  final _itemsPerPage = 5;
  int _currentPage = 0;

  // This async function simulates fetching results from Internet, etc.
  Future<List<CarMake>> fetchCarMaker() async {
    final list = <CarMake>[];
    // Uncomment the following line to see in real time now items are loaded lazily.
    // print('Now on page $_currentPage');
    var data = await client.post("$_baseUrl/listCarMake");
    var listCarMake = json.decode(data.body);
    List<CarMake> listx =
        List.from(listCarMake["Data"]).map((e) => CarMake.fromJson(e)).toList();
    list.addAll(listx);
    _currentPage++;
    return list;
  }
}
