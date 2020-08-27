class LoginUser {
   int CityID;
   String OldPassword;
   String Password;
   DateTime CreationDate;
   String Email;
   DateTime ExpirationDate;
   int ID;
   String ImageURL;
   bool IsAdmi;
   double Latitude;
  double Longitude;
   String Name;
   String Phone;
   String Token;
   DateTime UpdateDate;
   String Username;
   bool chnaged = false;

  LoginUser(
      {this.CityID,
      this.CreationDate,
      this.Email,
      this.ExpirationDate,
      this.OldPassword,
      this.Password,
      this.ID,
      this.ImageURL,
      this.IsAdmi,
      this.Latitude,
      this.Longitude,
      this.Name,
      this.Phone,
      this.Token,
      this.UpdateDate,
      this.Username});
  factory LoginUser.fromJson(Map loginUser) {
    return LoginUser(
        CityID: loginUser['CityID'],
        CreationDate: loginUser['CreationDate'] ==null?null:DateTime.parse(loginUser['CreationDate']),
        Email: loginUser['Email'],
        ExpirationDate: loginUser['ExpirationDate'] ==null?null:DateTime.parse(loginUser['ExpirationDate']),
        ID: loginUser['ID'],
        ImageURL: loginUser['ImageURL'],
        IsAdmi: loginUser['IsAdmi'],
        Latitude: loginUser['Latitude'],
        Longitude: loginUser['Longitude'],
        Name: loginUser['Name'],
        Phone: loginUser['Phone'],
        Password: loginUser['Password'],
        OldPassword: loginUser['OldPassword'],
        Token: loginUser['Token'],
        UpdateDate: loginUser['UpdateDate'] ==null?null:DateTime.parse(loginUser['UpdateDate']),
        Username: loginUser['Username']);
  }
  Map toJson()=>{        'CityID': this.CityID,
    'CreationDate': this.CreationDate ==null?null:(this.CreationDate).toString(),
    'Email': this.Email,
    'ExpirationDate': this.ExpirationDate ==null?null:(this.ExpirationDate).toString(),
    'ID': this.ID,
    'ImageURL': this.ImageURL,
    'IsAdmi': this.IsAdmi,
    'Latitude': this.Latitude,
    'Longitude': this.Longitude,
    'Name': this.Name,
    'Phone': this.Phone,
    'Password': this.Password,
    'OldPassword': this.OldPassword,
    'Token': this.Token,
    'UpdateDate': this.UpdateDate ==null?null:this.UpdateDate.toString(),
    'Username': this.Username};
}
