import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/screens/home_screen/home_screen.dart';
import 'package:beinglearners/screens/login_screen/login_screen.dart';
import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Slide> slides = new List();
  @override

  @override
  void initState() {
    super.initState();
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

  void onDonePress() async{

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (__)=>HomeScreen()));
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
        child: Text("Continue",style: TextStyle(color:ColorStyle().color_red,fontWeight: FontWeight.bold,fontSize: 16),),
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
    return new IntroSlider(
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
