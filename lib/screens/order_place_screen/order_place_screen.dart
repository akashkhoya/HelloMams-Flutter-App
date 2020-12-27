import 'dart:convert';
import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/model/login.dart';
import 'package:beinglearners/screens/home_screen/home_screen.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_place_screen_presenter.dart';

List<GetCartList> get_cart_List ;
bool loadingStatus =true;
int get_cart_listSize = 0 ;
int product_listSize = 0 ;
String click_id='';
double payable_amount=0;
String cart_id='';
String order_date ='Select Date';
bool checkedValue =false;

class OrderPlaceScreen extends StatefulWidget {
  final String cart_id;
  final String user_id;
  final double total_amount;
  OrderPlaceScreen(this.cart_id,this.user_id,this.total_amount);

  @override
  _OrderPlaceScreenState createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> implements CheckOutSummaryScreenContract {

  CheckOutSummaryScreenPresenter _presenter;

  _OrderPlaceScreenState() {
    _presenter = new CheckOutSummaryScreenPresenter(this);
  }


  DateTime _selectedDate = new DateTime.now(),
      _firstDate = new DateTime.now().add(new Duration(days: 2));

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: _firstDate,
        lastDate: _selectedDate.add(new Duration(days: 0))
    );
    if(picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        order_date =new DateFormat('yyyy-MM-dd').format(picked);
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

  var _query;

  call_api(){
    _query = {
      "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "userID": widget.user_id,
      "cartIDs": widget.cart_id,
      "paymentGatewayID": "string",
      "paymentMethod": "Pay on Delivery",
      "transactionID": "string",
      "totalAmount": widget.total_amount,
      "address": "Ansal API Palam Corporate Plaza, F-256, 1st Floor, B-Block, Palam Vihar, Gurugram, Haryana 122017",
      "orderStatus": "string",
      "paymentStatus": "string",
      "isCoupounApplied": true,
      "createdAt": "2020-12-25T16:52:28.002Z",
      "cartOrders": [
        {
          "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "productID": "string",
          "ipAddress": "string",
          "userID": "string",
          "productTitle": "string",
          "productImage": "string",
          "productQuantity": "string",
          "totalAmount": 0,
          "servicePrice": 0,
          "createdAt": "2020-12-25T16:52:28.002Z",
          "modifiedBy": "2020-12-25T16:52:28.002Z"
        }
      ]
    };
  }


  @override
  void initState() {
    // TODO: implement initState
    checkedValue =false;

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: ColorStyle().color_red,
        title: new Text('Schedule & Address'),
      ),
      body: widget_body(),
      bottomNavigationBar: new GestureDetector(
        onTap: (){
          _onLoading(true);
          call_api();
          _presenter.getInsertOrder(json.encode(_query).toString(),TOKEN);
        },
        child:new Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.green[800],
          ),
          height: 50,
          child: new Center(
            child: new Text('Procced',
              style: new TextStyle(color: ColorStyle().color_white,fontSize: 18,fontWeight: FontWeight.bold),),
          ),
        ),
      )
    );
  }
  widget_body(){
    return Container(
      child: new ListView(
        children: <Widget>[
          new Container(
            height: 150,
            child: new Container(
              margin: EdgeInsets.all(7),
              child: new Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                child: new Container(
                  padding: EdgeInsets.only(top: 15),
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                              flex: 3,
                              child: new Container(
                                padding: EdgeInsets.only(left: 12),
                                child: new Text('Address',
                                  style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 16),),
                              )),
                          new Expanded(
                              flex: 2,
                              child: new Container(
                                child: new Text(' Get Location',
                                  style: new TextStyle(color: ColorStyle().color_red,fontSize: 16),),
                              ))
                        ],
                      ),
                      new Container(
                        padding: EdgeInsets.all(10),
                        child: new Text('Ansal API Palam Corporate Plaza, F-256, 1st Floor, B-Block, Palam Vihar, Gurugram, Haryana 122017',
                        style: new TextStyle(fontSize: 15),),
                      )
                    ],
                  )
                )
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(left: 8,right: 8),
            width: MediaQuery.of(context).size.width,
            child: new Card(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 10,left: 10),
                    child: new Text('Set Your Schedule',
                    style: new TextStyle(fontSize: 16,color: ColorStyle().color_black),),
                  ),
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(

                            child: new Column(
                              children: <Widget>[

                                new Container(
                                  width: double.infinity,
                                  child: new Column(
                                    children: <Widget>[

                                      new Row(
                                        children: <Widget>[
                                          new Container(
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: ColorStyle().color_white,
                                            ),
                                            child: order_date==" "?
                                            new GestureDetector(
                                                onTap: (){
                                                  _selectDate(context);
                                                  setState(() {
                                       order_date = new DateFormat('dd-MMM-yyyy').format(_selectedDate);
//                                                     _dateOfBirthStatus=false;
                                                  });
                                                },
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Container(
                                                      height: 35,
                                                      width: MediaQuery.of(context).size.width/2.2,
                                                      padding: new EdgeInsets.only(left:10.0),
                                                      decoration: new BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),

                                                      ),
//                                      margin: const EdgeInsets.only(top: 10.0),
                                                      child: new Text(order_date,
                                                        style: new TextStyle(fontSize: 10.0,color: new ColorStyle().color_black,),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ):
                                            new GestureDetector(
                                                onTap: (){
                                                  _selectDate(context);
                                                  order_date = new DateFormat('dd-MMM-yyyy').format(_selectedDate);
                                                },
                                                child: new Row(
                                                  children: <Widget>[
                                                    new Container(
                                                      height: 35,
                                                      width: MediaQuery.of(context).size.width/2.2,
                                                      padding: const EdgeInsets.only(top: 10,left: 10),
                                                      decoration: new BoxDecoration(

                                                      ),
                                                      child: new Text(order_date,
//                                      child: new Text(new DateFormat('dd-MMM-yyyy').format(_selectedDate),
                                                        style: new TextStyle(fontSize: 10.0,color: new ColorStyle().color_black),
                                                        textScaleFactor: 1.4,

                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 10,top: 15),
                    child:new Column(
                      children: <Widget>[
                        new Container(
                          child: new Text('Normal Slots',
                          style: new TextStyle(color: ColorStyle().color_black,fontSize: 17),),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 12)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: ColorStyle().color_gray),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('09:00 am - 09:30 am',
                                    style: new TextStyle(fontSize: 14),),
                                  ),
                                )),
                            new Expanded(
                              flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: ColorStyle().color_gray),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('10:00 am - 10:30 am',
                                      style: new TextStyle(fontSize: 14),),
                                  ),
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: ColorStyle().color_gray),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('11:00 am - 11:30 am',
                                      style: new TextStyle(fontSize: 14),),
                                  ),
                                )),
                            new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: ColorStyle().color_gray),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('01:00 pm - 01:30 pm',
                                      style: new TextStyle(fontSize: 14),),
                                  ),
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: ColorStyle().color_gray),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('02:00 pm - 02:30 pm',
                                      style: new TextStyle(fontSize: 14),),
                                  ),
                                )),
                            new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: ColorStyle().color_gray),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('03:00 pm - 03:30 pm',
                                      style: new TextStyle(fontSize: 14),),
                                  ),
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: ColorStyle().color_gray),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('04:00 pm - 04:30 pm',
                                      style: new TextStyle(fontSize: 14),),
                                  ),
                                )),
                            new Expanded(
                                flex: 1,
                                child: new Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1,color: ColorStyle().color_gray),
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  height: 50,
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  child: new Center(
                                    child: new Text('05:00 pm - 05:30 pm',
                                      style: new TextStyle(fontSize: 14),),
                                  ),
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new Container(
                              width: MediaQuery.of(context).size.width/2.3,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: ColorStyle().color_gray),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              height: 50,
                              margin: EdgeInsets.only(left: 5,right: 5),
                              child: new Center(
                                child: new Text('06:00 pm - 06:30 pm',
                                  style: new TextStyle(fontSize: 14),),
                              ),
                            )

                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 15)),
                        new Row(
                          children: <Widget>[
                            new Container(
                              child: new Text('Payment Mode',
                              style: new TextStyle(color: ColorStyle().color_black,fontSize: 17),),
                            )
                          ],
                        ),
                       new Row(
                         children: <Widget>[
                           new Container(
                             padding: EdgeInsets.only(top: 12,left: 5,bottom: 14),
                             child: new Text('Only Pay on Delivery',
                             style: new TextStyle(color: Colors.green),),
                           )
                         ],
                       )
                      ],
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void onInserorderError(String errorTxt) {
    // TODO: implement onInserorderError
    _onLoading(true);
  }

  @override
  void onInserorderSuccess(AddToCart response) {
    // TODO: implement onInserorderSuccess
    _onLoading(true);
    if(response.value!=null){
      Fluttertoast.showToast(
          msg: "Order placed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: HomeScreen()));
    }
  }

}
