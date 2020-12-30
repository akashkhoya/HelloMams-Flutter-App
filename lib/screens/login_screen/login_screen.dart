import 'dart:convert';
import 'dart:io';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/common/shared_preferences.dart';
import 'package:beinglearners/model/login.dart';
import 'package:beinglearners/network_connection/network_connection.dart';
import 'package:beinglearners/screens/home_screen/home_screen.dart';
import 'package:beinglearners/screens/login_screen/login_screen_presenter.dart';
import 'package:beinglearners/screens/signup_screen/signup_screen.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _loginId, _loginPassword;
String  _emailError, _mobileError, _passwordError,name,joinedat,username,token;
bool password_obscureText = true;
String full_name='';
class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginScreenContract {

  LoginScreenPresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginScreenPresenter(this);
  }

  var _query;

  call_api(){
    _query = {
      "userEmail": _loginId,
      "password": _loginPassword,
      "macAddress": "string",
      "ipAddress": "string",
      "browser": "string",
      "browser_Version": "string",
      "active": true,
      "userAgent": "string",
      "location": "string",
      "os": "string",
      "os_Version": "string",
      "otp": 0

    };
  }

  void password_toggle() {
    setState(() {
      password_obscureText = !password_obscureText;
    });
  }
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  bool validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{4,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
  bool LoginValidation() {
    setState(() {
      status =true;
    });

    _passwordError = null;
    _emailError = null;

    if(_loginId == null ||_loginId=="") {
      setState(() {
        _emailError = 'Enter email';
        status = false;
      });

    }else{
      if( validateEmail(_loginId)){
        setState(() {
          status=true;
        });
      }else{
        setState(() {
          _emailError = 'Enter correct email';
          status = false;
        });
      }
    }
    if(_loginPassword==""){
      setState(() {
        _passwordError = 'Enter password';
        status = false;
      });
    }
    else if(_loginPassword == null || _loginPassword.length < 6) {
      setState(() {
        _passwordError = 'Enter correct password';
        status = false;
      });

    }
    return status;
  }
  bool _onLogin(){
    if(LoginValidation()){
      _onLoading(true);
      call_api();

      NetworkConnection.check().then((intenet) {
        if (intenet != null && intenet) {
          _presenter.getSignIn(json.encode(_query).toString());
        }else {
          Navigator.of(context).push(PageTransition(type: PageTransitionType.custom,child: InternetConnection(),
              duration: Duration(milliseconds: 0)));
        }

      });
    }
  }
  void _onLoading(bool status) {
    if(status) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5,bottom: MediaQuery.of(context).size.height/3.5),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              content:  new Container(
                  child: new Center(
                      child: new Column(
                        children: <Widget>[
                          Container(
                            height: 120,
                            child: new Image.asset('images/logo.jpeg',),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                  padding: EdgeInsets.only(top: 20),
                                  width:200,
                                  child: new Center(
                                    child: new Text('Please wait loading...',
                                      style: new TextStyle(color: new ColorStyle().color_red,fontSize: 17,fontWeight: FontWeight.bold),),
                                  )
                              )
                            ],
                          ),
                          new Padding(padding: EdgeInsets.only(top: 10)),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Image(image: new AssetImage('images/loader.gif',),width: 100,height: 40,)

                            ],
                          )
                        ],
                      )
                  )
              ),
            ),
          );
        },
      );
    }
    else
      Navigator.pop(context);
  }

  void dialogs(String mesg) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height/4,bottom: MediaQuery.of(context).size.height/4),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            content:  new Container(
                child: new Center(
                    child: new Column(
                      children: <Widget>[
                        Container(
                          height: 120,
                          child: new Image.asset('images/logo.jpeg',),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                padding: EdgeInsets.only(top: 0),
                                width:200,
                                child: new Center(
                                  child: new Text(mesg,
                                    style: new TextStyle(color: new ColorStyle().color_royal_blue,fontSize: 17,fontWeight: FontWeight.bold),),
                                )
                            )
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 10)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: new Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: ColorStyle().color_red,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),

                                child: Center(
                                  child: Text("OK"),
                                ),
                              ),
                            )

                          ],
                        )
                      ],
                    )
                )
            ),
          ),
        );
      },
    );
  }

  sharepref(bool data,String token,String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login_status', data);
    prefs.setString('token', token);
    prefs.setString('name', name);
  }

  void _openPage(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        HomeScreen()), (Route<dynamic> route) => false);

    }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              exit(0);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
        child:Scaffold(

          body: Container(
            height: MediaQuery.of(context).size.height,
            child: new Center(
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,

                children: <Widget>[

                  new Padding(padding: EdgeInsets.only(top: 30)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: Text("Sign to Continue",style: TextStyle(color: ColorStyle().color_red,
                            fontWeight: FontWeight.bold,fontSize: 30),),
                      ),
                    ],
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: new EdgeInsets.only(top: 20,left: 40),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                child: Text(_emailError==null?"":_emailError,style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          ),
                        ),

                        new Padding(padding: EdgeInsets.only(top: 10.0,left: 20,right: 20)),
                        new Container(
                          margin: EdgeInsets.only(left: 30,right: 30),

                          child:  new TextFormField(
                            cursorColor: new ColorStyle().color_red,
                            onChanged: (val)=> _loginId = val,
                            style: new TextStyle(
                              fontSize: 16.0,
                              height: 1.0,
                              color: ColorStyle().color_black,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            // obscureText: true,
                            decoration: new InputDecoration(
                              labelText: "Email" ,
                              //  errorText: _emailError,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // border: UnderlineInputBorder(borderRadius: null),
                              contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                              prefixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(start: 8.0,end: 5,bottom: 10,top: 5),
                                // child: new Image.asset('images/profile_small.png',width: 10,height: 10,color: new ColorStyle().color_black,),
                                // child: new Image.asset('images/profile.png',color: AppStyle().color_gray,height: 5,), // myIcon is a 48px-wide widget.

                                child: Icon(Icons.mail_outline,color: ColorStyle().color_red,),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: new EdgeInsets.only(top: _passwordError==null?0:20,left: 40),
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                child: Text(_passwordError==null?"":_passwordError,style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          ),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 10.0,left: 20,right: 20)),
                        new Container(
                          margin: EdgeInsets.only(left: 30,right: 30),

                          child:  new TextFormField(
                            cursorColor: new ColorStyle().color_red,
                            onChanged: (val)=> _loginPassword = val,
                            style: new TextStyle(
                              fontSize: 16.0,
                              height: 1.0,
                              color: ColorStyle().color_black,
                            ),
                            keyboardType: TextInputType.text,

                            obscureText: password_obscureText,
                            decoration: new InputDecoration(
                              //   errorText: _passwordError,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText:"Password" ,
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                              suffixIcon:Padding(
                                  padding: const EdgeInsets.only(right: 13,left: 13),
                                  child: new InkWell(
                                    splashColor: ColorStyle().color_white,
                                    onTap: (){
                                      password_toggle();
                                    },
                                    child: new Container(
                                      width: 1,
                                      height: 5,
                                      child: Image.asset(password_obscureText?"images/hide_eye.png":"images/eye.png",height: 5,width: 1,color: ColorStyle().color_red,),
                                    ),
                                  )
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(start: 8.0,end: 10,bottom: 10,top: 10),
                                //child: new Image.asset('images/lock.png',width: 8,height: 8,color: new ColorStyle().color_black,),
                                child: Icon(Icons.lock_outline,color:ColorStyle().color_red,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: new EdgeInsets.only(top: 10,right: 40),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Forgot Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: ColorStyle().color_red),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: new EdgeInsets.only(left: 30,right: 30,top: 40),
                    child: new InkWell(
                      onTap: (){
                        _onLogin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: ColorStyle().color_red,
                        ),
                        height: 45,
                        child: Center(
                          child: Text("Sign In",
                            style: TextStyle(
                                color: ColorStyle().color_white,fontSize: 20),),
                        ),
                      ),
                    ),
                  ),

                  new Padding(
                      padding: new EdgeInsets.only(left: 30,right: 30,top: 40),
                      child: new InkWell(
                        onTap: (){
                          Navigator.of(context).push(PageTransition(type: PageTransitionType.custom,child: SignUpPage(),
                              duration: Duration(milliseconds: 0)));
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have account?",style: TextStyle(color: ColorStyle().light_black,fontSize: 15),),
                            Text("Create a new account",style: TextStyle(color: ColorStyle().color_red,fontSize: 15),)
                          ],
                        ),
                      )
                  ),
                  /*new Padding(
                  padding: new EdgeInsets.only(left: 30,right: 30,top: 40),
                  child: new InkWell(
                    onTap: (){
                      Navigator.of(context).push(PageTransition(type: PageTransitionType.custom,child: HomeScreen(),
                          duration: Duration(milliseconds: 0)));
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("SKIP",style: TextStyle(color: ColorStyle().color_black,fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
              )*/

                ],
              ),
            )
          ),
        ));
  }

  @override
  void onClientLoginError(String errorTxt) {
    // TODO: implement onClientLoginError
    _onLoading(false);
    dialogs("Invalid Email and Password");
  }

  @override
  void onClientLoginSuccess(LoginData response) {
    // TODO: implement onClientLoginSuccess
    _onLoading(false);
    if(response.statusCode== 200){
      setState(() {
        TOKEN =response.value.valueData.access_token;
        full_name =response.value.valueData.fullName;
      });
      new SharedPreferencesClass().setloginstatus('true');
      sharepref(true,TOKEN,full_name);
      _openPage();
    }else{
      dialogs('');
    }

  }
}
