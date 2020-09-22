import 'dart:convert';

class CarImage {
  int ImageStatus;
  final int ID;
  final int CarID;
  final String ImageURL;
  final DateTime CreationDate;
  final DateTime UpdateDate;
  CarImage(
      {this.ImageStatus,
      this.ID,
      this.CarID,
      this.ImageURL,
      this.CreationDate,
      this.UpdateDate});
  factory CarImage.fromJson(Map<String, dynamic> jsonImage) {
    return CarImage(
      ImageStatus: jsonImage['ImageStatus'],
      ID: jsonImage['ID'],
      CarID: jsonImage['CarID'],
      ImageURL: jsonImage['ImageURL'],
      CreationDate: DateTime.parse(jsonImage['CreationDate']),
      UpdateDate: DateTime.parse(jsonImage['UpdateDate']),
    );
  }
  Map toJson() => {'ImageStatus': this.ImageStatus, 'ImageURL': this.ImageURL,'ID':this.ID,'CarID':this.CarID};
}

class Car {
  final int ID;
  final int CarMakeID;
  final int CarClassID;
  final int Model;
  final int Seats;
  final double Price;
  final int CityID;
  final int Status;
  final int UserID;
  final int MinimumAge;
  final String DrivingLicense;
  final bool WithDelivery;
  final double InsuranceAmount;
  final String InsuranceType;
  final List<CarImage> CarImages;
  final DateTime CreationDate;
  final DateTime UpdateDate;
  final bool IsPrime;

  Car(
      {this.ID,
      this.CarMakeID,
      this.CarClassID,
      this.Model,
      this.Seats,
      this.IsPrime,
      this.Price,
      this.CityID,
      this.Status,
      this.UserID,
      this.MinimumAge,
      this.DrivingLicense,
      this.WithDelivery,
      this.InsuranceAmount,
      this.InsuranceType,
      this.CarImages,
      this.CreationDate,
      this.UpdateDate});
  factory Car.fromJson(Map<String, dynamic> jsonCar) {
    return Car(
        ID: jsonCar['ID'],
        CarMakeID: jsonCar['CarMakeID'],
        CarClassID: jsonCar['CarClassID'],
        Model: jsonCar['Model'],
        Seats: jsonCar['Seats'],
        Price: jsonCar['Price'],
        CityID: jsonCar['CityID'],
        IsPrime: jsonCar['IsPrime'],
        Status: jsonCar['Status'],
        UserID: jsonCar['UserID'],
        MinimumAge: jsonCar['MinimumAge'],
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
  Map toJson() => {
        "Model": '${this.Model}',
        "InsuranceType": this.InsuranceType,
        "Seats": '${this.Seats}',
        "CityID": '${this.CityID}',
        "Status": '${this.Status}',
        "WithDelivery": '${this.WithDelivery}',
        "IsPrime": '${this.IsPrime}',
        "DrivingLicense": this.DrivingLicense,
        "Price": this.Price,
        "MinimumAge": this.MinimumAge,
        "InsuranceAmount": this.InsuranceAmount,
        "CarMakeID": this.CarMakeID,
        "CarClassID": this.CarClassID,
        "UserID": 1,
        "CarImages": this
            .CarImages
            .map((e) => JsonEncoder().convert(e.toJson()))
            .toList()
      };
  String toJsonString() =>
      '{"ID":${this.ID},"Model": "${this.Model}","InsuranceType": "${this.InsuranceType}","Seats": ${this.Seats},"CityID": "${this.CityID}","Status": "${this.Status}","WithDelivery": "${this.WithDelivery}","IsPrime": ${this.IsPrime},"DrivingLicense": "${this.DrivingLicense}","Price": ${this.Price},"MinimumAge": ${this.MinimumAge},"InsuranceAmount": ${this.InsuranceAmount},"CarMakeID": ${this.CarMakeID},"CarClassID": ${this.CarClassID},"UserID": ${this.UserID},"CarImages": ${this.CarImages.map((e) => JsonEncoder().convert(e.toJson())).toList()}}';
}
