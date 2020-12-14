import 'package:beinglearners/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Center(
    child: Container(
      color: Colors.white,
      width : 300,
      height: 250,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Text("",
            ),
          ),
          Expanded(
            flex: 3,
            child: new Center(
              child: new Image.asset("images/error.png",height: 200,width: 200),
            ),
          ),

          Expanded(
            flex: 3,
            child: new Container(
              padding: EdgeInsets.only(top: 20),
              child: new Text("Error occured due to unknown reason. Please try again later.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(color: new ColorStyle().color_dark_gray,fontSize: 17),maxLines: 3,
              ),
            )
          ),
          Expanded(
              flex: 1,
              child: new RaisedButton(
                  color: new ColorStyle().color_red,
                  child: new Text('Back',
                    style: new TextStyle(
                      fontSize: 14 ,
                      height: 1.0 ,
                      color: Colors.white ,
                    ),
                  ),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)) ,
                  onPressed: (){
//                    Navigator.pop(context);
                    Navigator.pop(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0)));
                  })
          ),
          new Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    ),
  );
}