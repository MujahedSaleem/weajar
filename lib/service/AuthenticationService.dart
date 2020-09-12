import 'dart:convert';

import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weajar/model/LoginUser.dart';

class AuthenticationService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static final AuthenticationService _singleton =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _singleton;
  }
  AuthenticationService._internal();
  String _tokenKey = 'Token';
  String _userKey = 'user';
  String currentPass;
  LoginUser user;
  int tokenMillsconed;
  final Client client = Client();
  final base_url = "https://api.weajar.com/Account/";

  signOut() async {
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': await getCurrentToken(),
      'content-type': 'application/json'
    };
    var result = await client.post(base_url + 'Logout', headers: header);
    await setToken(null);
    user = null;
    currentPass =null;
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<String> getCurrentToken() async {
    return await _prefs
        .then((value) => value.getString(_tokenKey))
        .catchError((error) => null);
  }

  LoginUser getCurrentUser()  {
    if (user != null) return user;
  }

  login(String email, String password) async {
    var response = await client.post(base_url + 'SignIn',
        body: {"username": email, "password": password});
    if (response.statusCode == 200) {
      final Map parsed = JsonDecoder().convert(response.body);
      if (parsed['Data'] == null)
        return false;
      user = LoginUser.fromJson(parsed['Data']);

      await setToken(user.Token);
      await setUser(json.encode(user));
      currentPass = password;
      return true;
    }
    await setToken(null);
    return false;
  }

  bool IsTokenNotActive() {
    return JwtDecoder.isExpired(_tokenKey);
  }

  setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    _tokenKey = token;
    prefs.setString(_tokenKey, token == null ? null : 'Bearer $token');
  }

  setUser(String user) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(_userKey, user);
  }
  resetData() async {
     await setToken(null);
    user = null;
    currentPass =null;


  }
}
