import 'dart:convert';

import 'package:http/http.dart';
import 'package:weajar/model/LoginUser.dart';

import 'AuthenticationService.dart';

class UserService {
  final Client client = Client();
  final base_url = "https://api.weajar.com/user/";
  var auth = AuthenticationService();
  Future updateUser() async {
    LoginUser newUser =  auth.getCurrentUser();
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json'
    };
    var result = await client.post(base_url + 'update',
        headers: header, body: JsonEncoder().convert(newUser.toJson()));
    if (result.statusCode == 200) {
      auth.getCurrentUser().chnaged = false;

      return true;

    }
    return false;
  }
  Future CreateUser(LoginUser user) async {
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json'
    };
    var result = await client.post(base_url + 'create',
        headers: header, body: JsonEncoder().convert(user.toJson()));
    if (result.statusCode == 200) {
      auth.getCurrentUser().chnaged = false;

      return true;

    }
    return false;

  }

}
