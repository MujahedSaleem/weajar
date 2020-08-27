import 'package:flutter/material.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/service/AuthenticationService.dart';

class ResetPassword extends StatefulWidget {
  static String routeName = 'resetPassword';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final auth = AuthenticationService();
  TextEditingController _currentPassword;
  TextEditingController _newPassword;
  TextEditingController _confirmPassword;
  bool firstCurrentChange = true;
  bool firstConfirmChange = true;
  bool matchCurrentPass = false;
  bool matchConfirm = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[800],
        body: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        }, child: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: new EdgeInsets.all(8.0),
                            child: CustomAppBar(
                                text: S.of(context).resetPass,
                                icon: Icons.arrow_back_ios,
                                onPressed: () {
                                  Navigator.pop(context);
                                })),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          controller: _currentPassword,
                          onChanged: (String pass) {
                            setState(() {
                              firstCurrentChange = false;
                              matchCurrentPass = auth.currentPass == pass;
                            });
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: firstCurrentChange
                                ? null
                                : matchCurrentPass
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.lightGreenAccent,
                                      )
                                    : Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      ),
                            fillColor: Colors.white,
                            hintText: S.of(context).currentPass,
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          controller: _newPassword,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            hintText: S.of(context).newPassword,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                          controller: _confirmPassword,
                          onChanged: (String x) {
                            setState(() {
                              firstConfirmChange = false;
                              matchConfirm = _newPassword.value.text == x &&
                                  x.trim() != '';
                            });
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: firstConfirmChange
                                ? null
                                : matchConfirm
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.lightGreenAccent,
                                      )
                                    : Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      ),
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                            hintText: S.of(context).confirmPassword,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                        ButtonTheme(
                          height: 50,
                          minWidth:
                          MediaQuery.of(context).size.width *
                              0.9,
                          child: RaisedButton(
                            color: Color.fromARGB(250, 237, 56, 38),
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 18),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(50),
                                side: BorderSide(
                                    color: Color.fromARGB(
                                        250, 237, 56, 38))),
                            onPressed: () async {
                              if(matchCurrentPass &&matchConfirm){
                                var currentUser =  auth.getCurrentUser();
                                currentUser.OldPassword = auth.currentPass;
                                currentUser.Password = _newPassword.value.text;
                                currentUser.chnaged = true;
                                Navigator.pop(context);
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Check Password"),
                                ));
                              }


                            },
                          ),
                        )
                      ]))));
        }))));
  }
}
