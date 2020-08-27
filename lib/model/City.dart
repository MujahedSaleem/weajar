class City {
  int ID;
  String NameEn;

  City(this.ID, this.NameEn);

  factory City.fromJson(Map<String, dynamic> jsonCity) {
    return City(jsonCity['ID'],jsonCity['NameEn']);

  }
}
