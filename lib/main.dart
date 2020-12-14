import 'package:beinglearners/routes.dart';
import 'package:beinglearners/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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

