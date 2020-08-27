// Root myDeserializedClass = JsonConvert.DeserializeObject<Root>(myJsonResponse);
class CarClass {
  final int ID;
  final int CarMakeID;
  final String NameAr;
  final String NameEn;
  final bool IsDeleted;
  final DateTime CreationDate;
  final DateTime UpdateDate;
  CarClass(
      {this.ID,
      this.CarMakeID,
      this.NameAr,
      this.NameEn,
      this.IsDeleted,
      this.CreationDate,
      this.UpdateDate});
  factory CarClass.fromJson(Map<String, dynamic> jsonCarMake) {
    return CarClass(
        ID: jsonCarMake['ID'],
        CarMakeID: jsonCarMake['CarMakeID'],
        NameAr: jsonCarMake['NameAr'],
        NameEn: jsonCarMake['NameEn'],
        IsDeleted: jsonCarMake['IsDeleted'],
        CreationDate: DateTime.parse(jsonCarMake['CreationDate']),
        UpdateDate: jsonCarMake['UpdateDate'] != null
            ? DateTime.parse(jsonCarMake['UpdateDate'])
            : null);
  }
}

class CarMake {
  final int ID;
  final String NameAr;
  final String NameEn;
  final List<CarClass> CarClasses;
  final DateTime CreationDate;
  final DateTime UpdateDate;
  CarMake({
    this.ID,
    this.NameAr,
    this.NameEn,
    this.CarClasses,
    this.CreationDate,
    this.UpdateDate,
  });
  factory CarMake.fromJson(Map<String, dynamic> jsonCarMake) {
    return CarMake(
      ID: jsonCarMake['ID'],
      NameAr: jsonCarMake['NameAr'],
      NameEn: jsonCarMake['NameEn'],
      CarClasses: List.from(jsonCarMake['CarClasses'])
          .map((e) => CarClass.fromJson(e))
          .toList(),
      CreationDate: DateTime.parse(jsonCarMake['CreationDate']),
      UpdateDate: jsonCarMake['UpdateDate'] != null
          ? DateTime.parse(jsonCarMake['UpdateDate'])
          : null,
    );
  }
}
