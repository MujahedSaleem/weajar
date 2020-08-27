import 'package:weajar/model/car.dart';
import 'package:weajar/model/user.dart';

class FullCarInfo implements Comparable {
  final int ID;
  final String CarMake;
  final String CarClass;
  final int Model;
  final int Seats;
  final double Price;
  final int City;
  final int Status;
  final User user;
  final int MinimumAge;
  final String DrivingLicense;
  final bool WithDelivery;
  final double InsuranceAmount;
  final String InsuranceType;
  final List<CarImage> CarImages;
  final DateTime CreationDate;
  final DateTime UpdateDate;
  final bool IsPrime;
  FullCarInfo(
      {this.ID,
      this.CarMake,
      this.CarClass,
      this.Model,
      this.Seats,
      this.Price,
      this.City,
      this.Status,
      this.user,
      this.MinimumAge,
      this.DrivingLicense,
      this.WithDelivery,
      this.InsuranceAmount,
      this.InsuranceType,
      this.CarImages,
      this.CreationDate,
        this.IsPrime,
      this.UpdateDate});
  factory FullCarInfo.fromJson(Map<String, dynamic> jsonCar) {
    return FullCarInfo(
        ID: jsonCar['ID'],
        CarMake: jsonCar['CarMakeID'],
        CarClass: jsonCar['CarClassID'],
        Model: jsonCar['Model'],
        Seats: jsonCar['Seats'],
        Price: jsonCar['Price'],
        City: jsonCar['CityID'],
        Status: jsonCar['Status'],
        user: jsonCar['UserID'],
        MinimumAge: jsonCar['MinimumAge'],
        IsPrime: jsonCar['IsPrime'],
        DrivingLicense: jsonCar['DrivingLicense'],
        WithDelivery: jsonCar['WithDelivery'],
        InsuranceAmount: jsonCar['InsuranceAmount'],
        InsuranceType: jsonCar['InsuranceType'],
        CarImages: List.from(jsonCar['CarImages'])
            .map((e) => CarImage.fromJson(e))
            .toList(),
        CreationDate: DateTime.parse(jsonCar['CreationDate']),
        UpdateDate: DateTime.parse(jsonCar['UpdateDate']));
  }

  @override
  int compareTo(other) {
    // TODO: implement compareTo

    if(this.IsPrime)
      return -1;
    else
      return 1 ;
  }
}
