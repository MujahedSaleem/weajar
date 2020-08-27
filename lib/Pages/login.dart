import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weajar/Pages/profile.dart';
import 'package:weajar/components/AppBar.dart';
import 'package:weajar/components/Loader.dart';
import 'package:weajar/components/SideDrawer.dart';
import 'package:weajar/generated/l10n.dart';
import 'package:weajar/service/AuthenticationService.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> scaffoldKey =
  new GlobalKey<ScaffoldState>();
  var authService =AuthenticationService();

  TextEditingController _usernameControlelr;
  TextEditingController _passwordControlelr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameControlelr = TextEditingController();
    _passwordControlelr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: SideDrawer(
          scaffoldKey: scaffoldKey,
        ),
        body: GestureDetector(onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        }, child: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Img/login.png'),
                          fit: BoxFit.cover)),
                  height: constraints.maxHeight,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: new EdgeInsets.all(8.0),
                                child: CustomAppBar(
                                    text: S.of(context).signIn,
                                    icon: Icons.menu,
                                    onPressed: () {
                                      if (scaffoldKey.currentState.hasDrawer)
                                        scaffoldKey.currentState.openDrawer();
                                    })),
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/Img/weAjar.png'))),
                              height: constraints.maxHeight * 0.5,
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: TextField(
                                          controller: _usernameControlelr,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            hintText: S.of(context).email,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(20.0)),
                                          ),
                                        ))),
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: TextField(
                                          controller: _passwordControlelr,
                                          obscureText: true,
                                          keyboardType: TextInputType.visiblePassword,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            hintText: S.of(context).password,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(20.0)),
                                          ),
                                        ))),
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: ButtonTheme(
                                    height: 50,
                                    minWidth: MediaQuery.of(context).size.width * 0.8,
                                    child: RaisedButton(
                                      color: Color.fromARGB(255, 237, 56, 38),
                                      child: Text(
                                        S.of(context).signIn,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Color.fromARGB(255, 237, 56, 38))),
                                      onPressed: () async {
                                        if(_passwordControlelr.value.text.trim()==''||_usernameControlelr.value.text.trim()==''){
                                        Fluttertoast.showToast(
                                            msg: "Fill user name and password ",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return ;}
                                        Column(mainAxisAlignment: MainAxisAlignment.center,children: [Loader(hight: MediaQuery.of(context).size.height*0.5,)],);
                                       var result = await authService.login(_usernameControlelr.value.text.trim(), _passwordControlelr.value.text.trim());
                                       if(result){
                                         Navigator.pushNamed(context, Profile.routeName);
                                       }else{
                                         Fluttertoast.showToast(
                                             msg: "User name or password is wrong ",
                                             toastLength: Toast.LENGTH_SHORT,
                                             gravity: ToastGravity.CENTER,
                                             timeInSecForIosWeb: 1,
                                             backgroundColor: Colors.red,
                                             textColor: Colors.white,
                                             fontSize: 16.0);
                                       }

                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).forgetPass,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        S.of(context).retrieve,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ])));
            }))));
  }
}
