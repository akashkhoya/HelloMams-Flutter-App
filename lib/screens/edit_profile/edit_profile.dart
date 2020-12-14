import 'dart:ui';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/common/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String name='',username='',email='',joinedat='';

  TextEditingController username_controller,name_controller,email_controller,joinedat_controller;



  Widget generateblurpopup(){
    return new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 3.0,sigmaY: 3.0),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5,bottom: MediaQuery.of(context).size.height/2.5,right: 100,left: 100 ),
        child: new Container(
          decoration: new BoxDecoration(color: ColorStyle().color_white.withOpacity(0.0)),
        ),
      ),
    );
  }

  void _pickImage()async{
    final imageSouces=await showDialog<ImageSource>(
        context: context,
      builder: (context)=>
          Stack(
            children: <Widget>[
              generateblurpopup(),
              new Container(
                child: Padding(
                  padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height/3,bottom: MediaQuery.of(context).size.height/3),
                  child: AlertDialog(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text("Browse Image For",textAlign: TextAlign.center,style: TextStyle(color: ColorStyle().color_white,fontSize: 17),),
                    backgroundColor: ColorStyle().color_red,
                    content: new Container(
                      child: Padding(
                        padding: new EdgeInsets.only(top: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                setState(() {
                                  Navigator.pop(context,ImageSource.camera);
                                });
                              },
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.camera_alt,color: ColorStyle().color_white,size: 22,),
                                    Text("Camera",textAlign: TextAlign.center,style: TextStyle(color: ColorStyle().color_white),)
                                  ],
                                ),
                              ),
                            ),
                            new Container(
                              width: 50,
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  Navigator.pop(context,ImageSource.gallery);
                                });
                              },
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.photo,color: ColorStyle().color_white,size: 22,),
                                    Text("Gallery",textAlign: TextAlign.center,style: TextStyle(color: ColorStyle().color_white),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
    if(imageSouces!=null){
      final file=await ImagePicker.pickImage(source: imageSouces,imageQuality: 70);
      if(file !=null){
        setState(() {
          select_image=file;
        });
      }
    }
  }
  void profile()async{
    email = await new SharedPreferencesClass().getEmail();
    name = await new SharedPreferencesClass().getName();
    username=await new SharedPreferencesClass().getUserName();
    joinedat=await new SharedPreferencesClass().getjoinedat();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    profile();
    username_controller=new TextEditingController(text:username );
    email_controller=new TextEditingController(text: email);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),

      ),
      body: new ListView(
        children: <Widget>[
          Container(
            child: new Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.only(top: 20),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorStyle().color_white,
                                boxShadow: [BoxShadow(color: ColorStyle().color_gray,blurRadius: 2,offset: Offset(1,2))]
                            ),

                            child:select_image==null?Icon(Icons.person_outline,color: ColorStyle().color_gray,size: 50,):
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              child: Image.file(select_image,fit: BoxFit.cover,),
                            )
                          )
                        ],
                      ),

                    ),
                   InkWell(
                     onTap: (){
                       _pickImage();
                     },
                     child:  Padding(
                       padding: new EdgeInsets.only(top: 100,left: 70),
                       child: new Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           new Container(
                             width: 40,
                             height: 40,
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: ColorStyle().color_red,
                                 boxShadow: [BoxShadow(color: ColorStyle().color_gray,blurRadius: 2,offset: Offset(1,1))]
                             ),

                             child:Center(
                               child: Icon(Icons.add_a_photo,size: 20,color: ColorStyle().color_white,),
                             ),
                           )
                         ],
                       ),

                     ),
                   )
                  ],
                ),
                new Padding(padding: EdgeInsets.only(top: 30.0)),
                new Container(
                  margin: EdgeInsets.only(left: 30,right: 30),

                  child:  new TextFormField(
                    cursorColor: new ColorStyle().color_dark_gray,
                    /* onChanged: (val)=> _loginId = val,*/
                    style: new TextStyle(
                      fontSize: 16.0,
                      height: 1.0,
                      color: ColorStyle().color_dark_gray,
                    ),
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    // obscureText: true,
                    controller: username_controller,
                    decoration: new InputDecoration(
                      labelText: "Username" ,
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

                        child: Icon(Icons.person_outline,color: ColorStyle().color_red,),
                      ),
                    ),
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new Container(
                  margin: EdgeInsets.only(left: 30,right: 30),

                  child:  new TextFormField(
                    cursorColor: new ColorStyle().color_dark_gray,
                    /* onChanged: (val)=> _loginId = val,*/
                    style: new TextStyle(
                      fontSize: 16.0,
                      height: 1.0,
                      color: ColorStyle().color_dark_gray,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // obscureText: true,
                    controller: email_controller,
                    decoration: new InputDecoration(
                      labelText: "Email" ,
                      //  errorText: _emailError,,
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
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new Container(
                  margin: EdgeInsets.only(left: 30,right: 30),

                  child:  new TextFormField(
                    cursorColor: new ColorStyle().color_dark_gray,
                    /* onChanged: (val)=> _loginId = val,*/
                    style: new TextStyle(
                      fontSize: 16.0,
                      height: 1.0,
                      color: ColorStyle().color_dark_gray,
                    ),
                    keyboardType: TextInputType.text,
                    // obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Name" ,
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

                        child: Icon(Icons.person_outline,color: ColorStyle().color_red,),
                      ),
                    ),
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new Container(
                  margin: EdgeInsets.only(left: 30,right: 30),

                  child:  new TextFormField(
                    cursorColor: new ColorStyle().color_dark_gray,
                    /* onChanged: (val)=> _loginId = val,*/
                    style: new TextStyle(
                      fontSize: 16.0,
                      height: 1.0,
                      color: ColorStyle().color_dark_gray,
                    ),
                    keyboardType: TextInputType.datetime,
                    // obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Joined At" ,
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

                        child: Icon(Icons.calendar_today,color: ColorStyle().color_red,),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.only(left: 30,right: 30,top: 40),
                  child: new InkWell(
                    onTap: (){
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: ColorStyle().color_red,
                      ),
                      height: 45,
                      child: Center(
                        child: Text("Update",
                          style: TextStyle(
                              color: ColorStyle().color_white,fontSize: 20),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
