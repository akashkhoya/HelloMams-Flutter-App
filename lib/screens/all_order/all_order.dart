import 'dart:ui';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/common/shared_preferences.dart';
import 'package:beinglearners/model/get_all_order.dart';
import 'package:beinglearners/screens/all_order/all_order_screen_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AllOrderScreen extends StatefulWidget {
  @override
  _AllOrderScreenState createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> implements AllOrderScreenContract {

  AllOrderScreenPresenter _presenter;
  String token='';

  _AllOrderScreenState() {
    _presenter = new AllOrderScreenPresenter(this);
  }

  sharepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token= prefs.getString('token');
      _presenter.getAllOrder(token, 'd09fc00f-d3e3-4c6e-bb2c-3b3bd7e20adc');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharepref();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),

      ),
      body: new Container(

        child: new ListView.builder(
          itemCount: 5,
            itemBuilder: (context,index){
              return new Container(
                child: new Text('tets'),
              );
            }),
      )
    );
  }

  @override
  void onAllOrderError(String errorTxt) {
    // TODO: implement onAllOrderError
  }

  @override
  void onAllOrderSuccess(AllOrderData response) {
    // TODO: implement onAllOrderSuccess
  }
}
