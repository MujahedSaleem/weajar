import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weajar/Pages/Aboutus.dart';
import 'package:weajar/Pages/login.dart';
import 'package:weajar/Pages/profile.dart';
import 'package:weajar/Pages/registration.dart';
import 'package:weajar/Pages/weCarList.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/service/AuthenticationService.dart';

import 'AppBar.dart';
import 'HorzLineDivider.dart';

class SideDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  SideDrawer({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var authService = AuthenticationService();
  bool signIn = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getCurrentToken().then((value) => {
          if (value != null)
            setState(() {
              signIn = false;
            })
        });
  }

  void navigate(BuildContext context, newRouteName) {
    Navigator.pop(widget.scaffoldKey.currentContext);
    var currentRouteName = ModalRoute.of(context).settings.name;
    if (newRouteName != currentRouteName)
      Navigator.pushNamedAndRemoveUntil(
          context, newRouteName, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[800],
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.099,
                  child: InkWell(
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(widget.scaffoldKey.currentContext);
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    S.of(context).menu,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Container(
              child: Column(
                children: [
                  InkWell(
                      child: Text(S.of(context).home,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      onTap: () {
                        navigate(context, WeCarList.routeName);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  HorzLineDivider(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  if (signIn)
                    SizedBox(
                      height: 20,
                    ),
                  if (signIn)
                    InkWell(
                        child: Text(S.of(context).signIn,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onTap: () {
                          navigate(context, Login.routeName);
                        }),
                  if (signIn)
                    SizedBox(
                      height: 20,
                    ),
                  if (signIn)
                    HorzLineDivider(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  if (!signIn)
                    SizedBox(
                      height: 20,
                    ),
                  if (!signIn)
                    InkWell(
                        child: Text(S.of(context).logout,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onTap: () async {

                          setState(() {
                            signIn = true;
                            Navigator.pop(widget.scaffoldKey.currentContext);
                            Navigator.pushNamed(context, WeCarList.routeName);
                          });
                          if (!await authService.signOut()) {
                            Fluttertoast.showToast(
                                msg: "something went wrong",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pop(widget.scaffoldKey.currentContext);
                            Navigator.pushNamed(context, Login.routeName);
                          }
                        }),
                  if (!signIn)
                    SizedBox(
                      height: 20,
                    ),
                  if (!signIn)
                    HorzLineDivider(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      child: Text(S.of(context).aboutus,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      onTap: () {
                        navigate(context, AboutUs.routeName);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  HorzLineDivider(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(S.of(context).contactus,
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(
                    height: 20,
                  ),
                  HorzLineDivider(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  if (!signIn)
                    SizedBox(
                      height: 20,
                    ),
                  if (!signIn)
                    InkWell(
                        child: Text(S.of(context).profile,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onTap: () {
                          navigate(context, Profile.routeName);
                        }),
                  if (!signIn)
                    SizedBox(
                      height: 20,
                    )
                ],
              ),
            ),
            Container(
                child: Column(children: [
              HorzLineDivider(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              InkWell(
                  child: Text(
                    '© WeAjar.com',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onTap: () => launch('https://www.weajar.com')),
            ]))
          ],
        ),
      ),
    );
  }
}
