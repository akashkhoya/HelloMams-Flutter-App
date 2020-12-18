import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class NetworkConnection{

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}



class InternetConnection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>InternetConnectionState();

}

class InternetConnectionState extends State<InternetConnection>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


   internet(){
    NetworkConnection.check().then((intenet) {
      if (intenet != null && intenet) {
        // Internet Present Case
        Navigator.pop(context);
      } else {
        showInSnackBar('Internet connection not available please try again...');
      }
      // No-Internet Case
    });
        }

   void showInSnackBar(String value) {
     _scaffoldKey.currentState.showSnackBar(new SnackBar(
         content: new Text(value)
     ));
   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldKey,
      body: new Container(
        child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset('images/internet_conne.png'),
                new Container(
                  margin: EdgeInsets.only(bottom: 10,top: 15),
                  child: new Text('No Internet connection',
                    style: new TextStyle(color: Colors.black,fontSize: 18),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: new Text('You are offline please check your internet connection',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.grey,fontSize: 15),
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Padding(
                    padding: new EdgeInsets.only(left: 10.0, right: 10.0),
                    child: new GestureDetector(
                      child: Container(
                        height: 30.0,
                        width: 110.0,
                        padding: EdgeInsetsDirectional.only(start: 8.0),
                        decoration: new BoxDecoration(
                          color: Colors.red[300]
                        ,borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: new Center(child: new Text('Retry', textAlign: TextAlign.center,
                          style: new TextStyle(color: Colors.white,fontSize: 19.0,
                            fontFamily: Localizations.localeOf(context).languageCode=='en'?
                            'Delicious' : 'Delicious',),
                          textScaleFactor: 0.8,
                        ),
                        ),
                      ),
                      onTap: (){
                        internet();
                      },
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}
