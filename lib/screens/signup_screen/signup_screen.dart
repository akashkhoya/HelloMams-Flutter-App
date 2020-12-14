import 'dart:convert';

import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/model/signUp.dart';
import 'package:beinglearners/screens/login_screen/login_screen.dart';
import 'package:beinglearners/screens/signup_screen/signUp_screen_presenter.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

String _firstName,email,mobile,password,confirmpassword;
String  _firstNameError,_emailError, _passwordError,mobileerror,_repeatPasswordError;
bool confirm_password_obscureText = true;
bool password_obscureText = true;
class SignUpPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  SignUpPageState createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> implements SignUpScreenContract {

  SignUpScreenPresenter _presenter;

  SignUpPageState() {
    _presenter = new SignUpScreenPresenter(this);
  }

  var _query ;



  call_api(){
    _query = {
        "emailID": email,
        "password": password,
        "confirmPassword": confirmpassword,
        "fullName": _firstName,
        "nationality": "indian",
        "contactNo": mobile,
    };
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  void _onLoading(bool status) {
    if(status) {
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
                                    child: new Text('Please wait loading...',
                                      style: new TextStyle(color: new ColorStyle().color_royal_blue,fontSize: 17,fontWeight: FontWeight.bold),),
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
                                Navigator.of(context).pop();
                              },
                              child: new Container(
                                width: 50,
                                height: 20,
                                color: ColorStyle().color_red,
                                child: Text("OK"),
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

  bool validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(value))
      return false;
    else
      return true;
  }

  bool _phoneNumberValidator(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regex = new RegExp(patttern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
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


  bool registrationValidation() {
    setState(() {
      status =true;
    });
    _firstNameError = null;
    _repeatPasswordError = null;
    _emailError = null;
    _passwordError = null;
  /*  mobileerror= null;*/
    _repeatPasswordError =null;

    if(_firstName == null || _firstName.trim().length == 0) {
      setState(() {
        _firstNameError = 'Enter First Name';
        status = false;
      });

    }else if(_firstName==""||_firstName == null || _firstName.trim().length == 0) {
      setState(() {
        _firstNameError =  'Enter Valid First Name';
        status = false;
      });
    } else{
      if( validateName(_firstName)){
        setState(() {
          status=true;
        });
      }else{
        setState(() {
          _firstNameError = 'Enter Only Alphabet';
          status = false;
        });
      }
    }

    if(email == null || email=="") {
      setState(() {
        _emailError = 'Enter Email';
        status = false;
      });

    }else{
      if( validateEmail(email)){
      }else{
        setState(() {
          _emailError = "Enter Correct Email";
          status = false;
        });
      }
    }
    if(mobile==""||mobile == null){
      setState(() {
        mobileerror = 'Enter mobile number';
        status = false;
      });
    }else if(mobile.trim().length != 10 ) {
      setState(() {
        mobileerror = 'Enter valid mobile number';
        status = false;
      });


    }

    if(password == null || password=="") {
      setState(() {
        _passwordError = 'Enter Password';
        status = false;
      });
    }else if(password.length < 8){
      setState(() {
        _passwordError = 'Enter minimum 8 characters at least';
        status = false;
      });
    }

    if(password!=confirmpassword){
      setState(() {
        _repeatPasswordError ='Enter Correct Confirm Passowrd ';
        status = false;
      });

    }
    return status;
  }
  void _onSignUp() {

    if(registrationValidation()){
      _onLoading(true);
      call_api();
      _presenter.getSignUp(json.encode(_query).toString());
    }

  }
  void password_toggle() {
    setState(() {
      password_obscureText = !password_obscureText;
    });
  }
  void confirm_password_toggle() {
    setState(() {
      confirm_password_obscureText = !confirm_password_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:  Container(
          height: MediaQuery.of(context).size.height,
          child:ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.only(top: 30,left: 10),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child:  new Container(
                        child: Icon(Icons.arrow_back,color: ColorStyle().color_royal_blue,),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height/6-100),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(padding:EdgeInsets.only(left: 0),),
                    new Container(
                      child: Center(
                        child: Text("Create Account",textAlign: TextAlign.center,
                          style: TextStyle(color: ColorStyle().color_red,
                              fontSize: 35,fontWeight: FontWeight.bold),),
                      )
                    )
                  ],
                ),
              ),

              new Align(
                alignment: Alignment.center,
                child: new Padding(
                  padding: EdgeInsets.only(right: 0,top: 0),
                  child: new Text('Create new Account',
                    style: new TextStyle(
                        color: new ColorStyle().color_gray_light
                        ,fontSize: 15,
                        fontWeight: FontWeight.bold),),),
              ),
              new Container(
                child:  new Column(
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.only(top: 5.0,left: 40),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            child: Text(_firstNameError==null?"":_firstNameError,style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 7.0,left: 20,right: 20)),
                    new Container(
                      margin: EdgeInsets.only(left: 30,right: 30),
                      child:  new TextFormField(
                        cursorColor: new ColorStyle().color_red,
                        onChanged: (val)=> _firstName = val,
                        style: new TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                          color: ColorStyle().color_dark_gray,

                        ),
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 8.0,end: 5,bottom: 10,top: 5),
                              child:Icon(Icons.person_outline,color: ColorStyle().color_red,)
                            ),
                            labelText: "User name"
                        ),
                      ),
                    ),

                    Padding(
                      padding: new EdgeInsets.only(top:_emailError==null?0:5.0,left: 40),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            child: Text(_emailError==null?"":_emailError,style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 7.0,left: 20,right: 20)),
                    new Container(
                      margin: EdgeInsets.only(left: 30,right: 30),
                      child:  new TextFormField(
                        cursorColor: new ColorStyle().color_red,
                        onChanged: (val)=> email = val,
                        style: new TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                          color: ColorStyle().color_dark_gray,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 8.0,end: 5,bottom: 10,top: 5),
                              child: Icon(Icons.mail_outline,color: ColorStyle().color_red,)
                            ),
                           labelText: "Enter Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.only(top:mobileerror==null?0:5.0,left: 40),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            child: Text(mobileerror==null?"":mobileerror,style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 7.0,left: 20,right: 20)),
                    new Container(
                      margin: EdgeInsets.only(left: 30,right: 30),

                      child:  new TextFormField(
                        cursorColor: new ColorStyle().color_red,
                        // obscureText: password_obscureText,
                        onChanged: (val)=> mobile = val,
                        style: new TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                          color: ColorStyle().color_dark_gray,
                        ),
                        decoration: new InputDecoration(

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                          prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 8.0,end: 5,bottom: 10,top: 5),
                              child: Icon(Icons.phone_iphone,color: ColorStyle().color_red,)
                          ),
                          labelText: "Mobile",
                        ),
                      ),
                    ),

                    Padding(
                      padding: new EdgeInsets.only(top:_passwordError==null?0:5.0,left: 40),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            child: Text(_passwordError==null?"":_passwordError,style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 7.0,left: 20,right: 20)),
                    new Container(
                      margin: EdgeInsets.only(left: 30,right: 30),

                      child:  new TextFormField(
                        cursorColor: new ColorStyle().color_red,
                        obscureText: password_obscureText,
                        onChanged: (val)=> password = val,
                        style: new TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                          color: ColorStyle().color_dark_gray,
                        ),
                        decoration: new InputDecoration(

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                          suffixIcon:Padding(
                            padding: const EdgeInsets.only(right: 13,left: 13),
                            child: new InkWell(
                              onTap: (){
                                password_toggle();
                              },
                              child: new Container(
                                width: 1,
                                height: 5,
                                child:
                                Image.asset(password_obscureText?"images/hide_eye.png":"images/eye.png",height: 5,width: 1,color: ColorStyle().color_red,),
                              ),
                            )
                          ),
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 8.0,end: 5,bottom: 10,top: 5),
                              child: Icon(Icons.lock_outline,color: ColorStyle().color_red,)
                            ),
                            labelText: "Password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.only(top: _repeatPasswordError==null?0:5.0,left: 40),
                      child: new Row(
                        children: <Widget>[
                          new Container(
                            child: Text(_repeatPasswordError==null?"":_repeatPasswordError,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 7.0,left: 20,right: 20)),
                    new Container(
                      margin: EdgeInsets.only(left: 30,right: 30),

                      child:  new TextField(
                        cursorColor: new ColorStyle().color_red,
                        onChanged: (val)=> confirmpassword = val,
                        style: new TextStyle(
                          fontSize: 16.0,
                          height: 1.0,
                          color: ColorStyle().color_dark_gray,
                        ),
                        obscureText: confirm_password_obscureText,

                        decoration: new InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                            suffixIcon:Padding(
                                padding: const EdgeInsets.only(right: 13,left: 13),
                                child: new InkWell(
                                  onTap: (){
                                    confirm_password_toggle();
                                  },
                                  child: new Container(
                                    width: 1,
                                    height: 5,
                                    child:
                                    Image.asset(confirm_password_obscureText?"images/hide_eye.png":"images/eye.png",height: 5,width: 1,color: ColorStyle().color_red,),
                                  ),
                                )
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 8.0,end: 10,bottom: 10,top: 10),
                              child: Icon(Icons.lock_outline,color: ColorStyle().color_red,)
                            ),
                            labelText: "Confirm Password",

                        ),

                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: new EdgeInsets.only(top: 40,left: 30,right: 30),
                child: InkWell(
                  onTap: (){
                    _onSignUp();
                  },
                  child: new Container(
                      height: 45,
                      //margin: EdgeInsets.only(left: 20,right: 20),
                      decoration: new BoxDecoration(
                        gradient:new LinearGradient(
                          colors: [new ColorStyle().color_red,ColorStyle().color_red],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.5, 0.0),
                          tileMode: TileMode.clamp,

                        ),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: ColorStyle().color_white,

                      ),

                      child: new Center(
                        child: Text("Sign up",
                          style: TextStyle(
                              color: ColorStyle().color_white,fontSize: 20),),
                      )
                  ),
                ),
              ),
              Padding(
                padding: new EdgeInsets.only(top: 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.only(left: 30,right: 30,top: 25),
                        child: new InkWell(
                          onTap: (){
                            Navigator.of(context).push(PageTransition(type: PageTransitionType.custom,child: LoginPage(),
                                duration: Duration(milliseconds: 0)));
                          },
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have a account?",style: TextStyle(color: ColorStyle().light_black,fontSize: 17),),
                              Text("Sign In",style: TextStyle(color: ColorStyle().color_red,fontSize: 17),)
                            ],
                          ),
                        )
                    ),

                  ],
                ),
              )
            ],
          )
        )
    );
  }

  @override
  void onClientSignUpError(String errorTxt) {
    // TODO: implement onClientSignUpError
    dialogs(errorTxt);
  }

  @override
  void onClientSignUpSuccess(SignUpData response) {
    // TODO: implement onClientSignUpSuccess
    _onLoading(false);
    if(response.value==null){
      dialogs(response.value);
    }else{

      Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: LoginPage()));
    }
  }

}
