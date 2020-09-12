import 'package:weajar/model/City.dart';
import 'package:weajar/model/car.dart';

class Repo {
  static final Repo _singleton = Repo._internal();

  factory Repo() {
    return _singleton;
  }
  Repo._internal();
  List<Car> _fullCars;
  List<City> _Cities;
  set fullCarInfo(List<Car> cars) => _fullCars = cars;
  get fullCarInfo => _fullCars;
  set allCity(List<City> cities) => _Cities = cities;
  List<City> get  allCity => _Cities;
}
