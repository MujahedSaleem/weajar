import 'package:weajar/model/car.dart';

class Repo {
  static final Repo _singleton = Repo._internal();

  factory Repo() {
    return _singleton;
  }
  Repo._internal();
  List<Car> fullCars;

  set fullCarInfo(List<Car> cars) => fullCars = cars;
  get fullCarInfo => fullCars;
}
