import 'dart:async';

import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/shared_preferences.dart';
import 'package:beinglearners/screens/home_screen/home_screen.dart';
import 'package:beinglearners/screens/login_screen/login_screen.dart';
import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool loginstatus =false;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Slide> slides = new List();


  void getstatus()async{
    Timer(
        Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));

  }

  @override
  void initState() {
    super.initState();
    sharepref();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
     statusBarIconBrightness: Brightness.light
    ));
    slides.add(
      new Slide(
        backgroundImageFit: BoxFit.cover,

        backgroundImage:"images/blog1_img.jpeg",
        backgroundBlendMode: BlendMode.overlay
      ),
    );
    slides.add(
      new Slide(
        backgroundImageFit: BoxFit.cover,
        backgroundImage:"images/blog2_img.jpeg",
          backgroundBlendMode: BlendMode.overlay
      ),
    );
    slides.add(
      new Slide(
        backgroundImage:"images/blog3_img.jpeg",
        backgroundImageFit: BoxFit.cover,
          backgroundBlendMode: BlendMode.overlay
      ),
    );
  }
  sharepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginstatus= prefs.getBool('login_status');
      if(loginstatus==true){
        getstatus();
      }

    });
  }


  void onDonePress() async{
    if(loginstatus==true){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>LoginPage()));
    }
   print(loginstatus);
    // TODO: go to next screen
  }

  void onSkipPress() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>LoginPage()));
    // TODO: go to next screen
  }

  /*Widget renderNextBtn() {
    return Container(
      child: Text("Next",style: TextStyle(color:ColorStyle().color_royal_blue),),
    );
  }*/

  Widget renderDoneBtn() {
    return Container(
      child: new Center(
        child: Text("Continue",style: TextStyle(color:ColorStyle().color_red,fontWeight: FontWeight.bold,fontSize: 14),),
      )
    );
  }

  /*Widget renderSkipBtn() {
    return Container(
      child: Text("Skip",style: TextStyle(color:ColorStyle().color_royal_blue),),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return loginstatus?
    new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Image.asset('images/splash.jpeg',fit: BoxFit.fill,)
    )
    :new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      // renderSkipBtn: this.renderSkipBtn(),
      // onSkipPress: this.onSkipPress,

      // colorSkipBtn: ColorStyle().color_white,

      // Next, Done button
      onDonePress: this.onDonePress,
      // renderNextBtn: this.renderNextBtn(),
      renderDoneBtn: this.renderDoneBtn(),
      // colorDoneBtn: ColorStyle().color_white,
      // widthDoneBtn:100,
      // widthSkipBtn:100,
      // widthPrevBtn:100,
      // Dot indicator
      colorDot:ColorStyle().color_gray,
      colorActiveDot:ColorStyle().color_red,
      sizeDot: 9.0,
    );
  }
}

class SingleSplash extends StatefulWidget {
  @override
  _SingleSplashState createState() => _SingleSplashState();
}

class _SingleSplashState extends State<SingleSplash> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: new Image.asset('images/splash.jpeg',fit: BoxFit.fill,)
    );
  }
}
