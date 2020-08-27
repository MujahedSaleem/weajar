import 'package:http/http.dart';
import 'package:weajar/service/AuthenticationService.dart';

class Account {
  final Client client = Client();
  final base_url = "https://api.weajar.com/Account/";
  var auth = AuthenticationService();
  Future updateAccountPassword() async {
    var newUser = auth.getCurrentUser();
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': await auth.getCurrentToken(),
      'content-type': 'application/json'
    };
    var result =
        await client.post(base_url + 'changePassword', headers: header,body: newUser.toJson().toString());
    if (result.statusCode == 200) {
      auth.getCurrentUser().chnaged = false;
      return true;
    }
    return result.statusCode;
  }
}
