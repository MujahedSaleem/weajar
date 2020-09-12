import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weajar/Pages/resetPassword.dart';
import 'package:weajar/Pages/weCarList.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/HorzLineDivider.dart';
import 'package:weajar/components/Loader.dart';
import 'package:weajar/components/TextWithDropDown.dart';
import 'package:weajar/components/TextWithText.dart';
import 'package:weajar/components/TextWithTextField.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/model/Isearch.dart';
import 'package:weajar/model/LoginUser.dart';
import 'package:weajar/service/Account.dart';
import 'package:weajar/service/AuthenticationService.dart';
import 'package:weajar/service/CitiesFetcher.dart';

class EditProfile extends StatefulWidget {
  static const routeName = 'editProfile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var auth = AuthenticationService();

  TextEditingController _nameController;
  TextEditingController _phoneController;
  LoginUser currentUser;
  final _cityFetcher = CitiesFetcher();
  final _accountService = Account();
  List<FiealdSearch<int>> Cities;
  int city = 0;
  bool _isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (auth.IsTokenNotActive()) auth.signOut();

    _nameController = new TextEditingController();
    _phoneController = new TextEditingController();

    currentUser = auth.getCurrentUser();
    currentUser.Username;
    _nameController.text = currentUser.Name;
    _phoneController.text = currentUser.Phone;

    _cityFetcher.fetchCities().then((value) {
      setState(() {
        Cities = value.map((e) => FiealdSearch(e.NameEn, e.ID)).toList();
        if (city == 0) city = Cities[0].Key;
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xff48484A),
        body: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        }, child: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              width: MediaQuery.of(context).size.width,

              child: SingleChildScrollView(
                  child: _isloading
                      ? Loader()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                                  padding: new EdgeInsets.all(8.0),
                                  child: CustomAppBar(
                                      text: S.of(context).editprofile,
                                      icon: Icons.arrow_back_ios,
                                      iconColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })),
                              HorzLineDivider(
                                color: Color(0xff3D434A),
                                width: MediaQuery.of(context).size.width,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: TextWithText(
                                          text: S.of(context).userName,
                                          text2: currentUser.Username),
                                    ),
                                    HorzLineDivider(
                                      color: Color(0xff3D434A),
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    TextWithTextfield(
                                      controlelr: _nameController,
                                      text: S.of(context).name,
                                    ),
                                    HorzLineDivider(
                                      color: Color(0xff3D434A),
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 15),
                                      child: TextWithText(
                                          text: S.of(context).email,
                                          text2: currentUser.Email),
                                    )
                                   ,
                                    HorzLineDivider(
                                      color: Color(0xff3D434A),
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    TextWithTextfield(
                                      controlelr: _phoneController,
                                      text: S.of(context).phone,
                                    ),
                                    HorzLineDivider(
                                      color: Color(0xff3D434A),
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    TextWithDropDown(
                                      selectedValue: city,
                                      items: Cities,
                                      text: S.of(context).city,
                                      onChange: (int x) {},
                                    ),
                                    HorzLineDivider(
                                      color: Color(0xff3D434A),
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Row(
                                      children: [

                                        InkWell(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                              S.of(context).resetPass,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          onTap: () async {
                                            if (auth.IsTokenNotActive()) {
                                              auth.signOut();
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  WeCarList.routeName,
                                                  (route) => false);
                                            }
                                            await Navigator.pushNamed(context,
                                                ResetPassword.routeName);
                                            if (auth.getCurrentUser().chnaged) {
                                              await _accountService
                                                  .updateAccountPassword();
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text('Password Changed'),
                                              ));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                    ButtonTheme(
                                      height: 50,
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                      child: RaisedButton(
                                        color: Color.fromARGB(250, 237, 56, 38),
                                        child: Text(
                                          S.of(context).save,
                                          style: TextStyle(fontSize: 18,color: Colors.white),

                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    250, 237, 56, 38))),
                                        onPressed: () {
                                          currentUser.Name =
                                              _nameController.value.text;
                                          currentUser.Phone =
                                              _phoneController.value.text;
                                          currentUser.chnaged = true;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ])));
        }))));
  }
}
