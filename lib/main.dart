import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weajar/Pages/Aboutus.dart';
import 'package:weajar/Pages/ContactUs.dart';
import 'package:weajar/Pages/EditCar.dart';
import 'package:weajar/Pages/login.dart';
import 'package:weajar/Pages/profile.dart';
import 'package:weajar/Pages/registration.dart';
import 'package:weajar/Pages/resetPassword.dart';
import 'package:weajar/Pages/weCarDetails.dart';
import 'package:weajar/generated/l10n.dart';
import 'Pages/AddNewCar.dart';
import 'Pages/AdvanceSearch.dart';
import 'Pages/EditProfile.dart';
import 'Pages/SplashScreen.dart';
import 'Pages/weCarList.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home:

      SplashScreen(),

      routes: {
        WeCarList.routeName: (BuildContext context) => WeCarList(),
        WeCarDetails.routeName: (BuildContext context) => WeCarDetails(),
        AdvanceSearch.routeName: (BuildContext context) => AdvanceSearch(),
        AboutUs.routeName: (BuildContext context) => AboutUs(),
        Profile.routeName: (BuildContext context) => Profile(),
        AddEditCar.routeName: (BuildContext context) => AddEditCar(),
        Login.routeName: (BuildContext context) => Login(),
        EditProfile.routeName: (BuildContext context) => EditProfile(),
        ResetPassword.routeName: (BuildContext context) => ResetPassword(),
        Registration.routeName: (BuildContext context) => Registration(),
        ContactUs.routeName: (BuildContext context) => ContactUs(),
        EditCar.routeName: (BuildContext context) => EditCar(),
      },

    );
  }
}
