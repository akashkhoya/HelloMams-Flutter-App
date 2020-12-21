import 'package:beinglearners/routes.dart';
import 'package:beinglearners/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  sharepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginstatus= prefs.getBool('login_status');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    sharepref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red
      ),
      routes: routes,
      home: SplashScreen(),
    );
  }
}

