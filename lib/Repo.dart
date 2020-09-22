import 'package:weajar/model/CarMake.dart';
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
  List<CarMake> _carmake;
  set fullCarInfo(List<Car> cars) => _fullCars = cars;
  List<Car> get fullCarInfo => _fullCars;
  set allCity(List<City> cities) => _Cities = cities;
  List<City> get  allCity => _Cities;
  set CarMakers (List<CarMake> make) => _carmake =make;
  List<CarMake> get CarMakers => _carmake;
}
