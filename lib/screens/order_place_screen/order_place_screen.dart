import 'dart:convert';
import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/model/login.dart';
import 'package:beinglearners/screens/home_screen/home_screen.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_place_screen_presenter.dart';
import 'package:geolocator/geolocator.dart';


List<GetCartList> get_cart_List ;
bool loadingStatus =true;
int get_cart_listSize = 0 ;
int product_listSize = 0 ;
String click_id='';
double payable_amount=0;
String cart_id='';
String order_date ='Select Date';
bool checkedValue =false;
String address ='';
int day=0;
int month=0;
int year=0;
String schedule_date='';
bool slot1=true;
bool slot2=false;
bool slot3=false;
bool slot4=false;
bool slot5=false;
bool slot6=false;
bool slot7=false;
bool slot8=false;
bool slot9=false;


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
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress ='';
  TextEditingController address_controller;



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
                                  padding: EdgeInsets.only(top: 10),
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
      "cartIDs": '1,2',
      "paymentGatewayID": "string",
      "paymentMethod": "Pay on Delivery",
      "transactionID": "string",
      "totalAmount": widget.total_amount,
      "address": address,
      "orderStatus": "string",
      "paymentStatus": "string",
      "isCoupounApplied": true,
      "createdAt": '2020-12-25T16:52:28.002Z',
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

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.thoroughfare},${place.name},${place.subLocality},${place.locality},${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        address_controller=new TextEditingController(text:_currentAddress);
        address =_currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  getCurrentTime(){
    setState(() {
      DateTime now = DateTime.now();
      day = int.parse(new DateFormat('dd').format(now));
      month = int.parse(new DateFormat('MM').format(now));
      year = int.parse(new DateFormat('yyyy').format(now));
      schedule_date=now.toString();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    address_controller=new TextEditingController(text:_currentAddress);
    checkedValue =false;
    _getCurrentLocation();
    getCurrentTime();

setState(() {
  slot1=true;
  slot2=false;
  slot3=false;
  slot4=false;
  slot5=false;
  slot6=false;
  slot7=false;
  slot8=false;
  slot9=false;
  // schedule_date=now.toString()+'|'+'09:00 am - 09:30 am';
});

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
                              child: new GestureDetector(
                                onTap: (){
                                  _getCurrentLocation();
                                },
                                child: new Container(
                                  child: new Text(' Get Location',
                                    style: new TextStyle(color: ColorStyle().color_red,fontSize: 16),),
                                )
                              ))
                        ],
                      ),
                      new Container(
                        padding: EdgeInsets.all(10),
                        child: new TextField(
                          controller: address_controller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Current Address'
                          ),
                          onChanged: (value){
                            address =value;
                          },
                          maxLines: 2,
                        ))
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
                                  child:  CalendarTimeline(
                                    initialDate: DateTime(year, month, day),
                                    firstDate: DateTime(year, month, day),
                                    lastDate: DateTime(2021, 12, 31),
                                    onDateSelected: (date){
                                      schedule_date = date.toString();
                                      print(schedule_date);
                                    },
                                    leftMargin: 20,
                                    monthColor: Colors.blueGrey,
                                    dayColor: Colors.teal[200],
                                    activeDayColor: Colors.white,
                                    activeBackgroundDayColor: Colors.redAccent[100],
                                    dotsColor: Color(0xFF333A47),
                                    selectableDayPredicate: (date) => date.day != 23,
                                    locale: 'en_ISO',
                                  )
                                )
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
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=true;
                                      slot2=false;
                                      slot3=false;
                                      slot4=false;
                                      slot5=false;
                                      slot6=false;
                                      slot7=false;
                                      slot8=false;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'09:00 am - 09:30 am';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: slot1?ColorStyle().color_red:ColorStyle().color_white

                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('09:00 am - 09:30 am',
                                        style: new TextStyle(fontSize: 14,color: slot1?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                )),
                            new Expanded(
                              flex: 1,
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=false;
                                      slot2=true;
                                      slot3=false;
                                      slot4=false;
                                      slot5=false;
                                      slot6=false;
                                      slot7=false;
                                      slot8=false;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'10:00 am - 10:30 am';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: slot2?ColorStyle().color_red:ColorStyle().color_white
                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('10:00 am - 10:30 am',
                                        style: new TextStyle(fontSize: 14,color: slot2?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=false;
                                      slot2=false;
                                      slot3=true;
                                      slot4=false;
                                      slot5=false;
                                      slot6=false;
                                      slot7=false;
                                      slot8=false;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'11:00 am - 11:30 am';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: slot3?ColorStyle().color_red:ColorStyle().color_white
                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('11:00 am - 11:30 am',
                                        style: new TextStyle(fontSize: 14,color: slot3?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                )),
                            new Expanded(
                                flex: 1,
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=false;
                                      slot2=false;
                                      slot3=false;
                                      slot4=true;
                                      slot5=false;
                                      slot6=false;
                                      slot7=false;
                                      slot8=false;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'01:00 pm - 01:30 pm';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: slot4?ColorStyle().color_red:ColorStyle().color_white
                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('01:00 pm - 01:30 pm',
                                        style: new TextStyle(fontSize: 14,color: slot4?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=false;
                                      slot2=false;
                                      slot3=false;
                                      slot4=false;
                                      slot5=true;
                                      slot6=false;
                                      slot7=false;
                                      slot8=false;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'02:00 pm - 02:30 pm';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: slot5?ColorStyle().color_red:ColorStyle().color_white
                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('02:00 pm - 02:30 pm',
                                        style: new TextStyle(fontSize: 14,color: slot5?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                )),
                            new Expanded(
                                flex: 1,
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=false;
                                      slot2=false;
                                      slot3=false;
                                      slot4=false;
                                      slot5=false;
                                      slot6=true;
                                      slot7=false;
                                      slot8=false;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'03:00 pm - 03:30 pm';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: slot6?ColorStyle().color_red:ColorStyle().color_white
                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('03:00 pm - 03:30 pm',
                                        style: new TextStyle(fontSize: 14,color: slot6?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                flex: 1,
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=false;
                                      slot2=false;
                                      slot3=false;
                                      slot4=false;
                                      slot5=false;
                                      slot6=false;
                                      slot7=true;
                                      slot8=false;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'04:00 pm - 04:30 pm';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: slot7?ColorStyle().color_red:ColorStyle().color_white
                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('04:00 pm - 04:30 pm',
                                        style: new TextStyle(fontSize: 14,color: slot7?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                )),
                            new Expanded(
                                flex: 1,
                                child: new GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      slot1=false;
                                      slot2=false;
                                      slot3=false;
                                      slot4=false;
                                      slot5=false;
                                      slot6=false;
                                      slot7=false;
                                      slot8=true;
                                      slot9=false;
                                      // schedule_date='';
                                      // schedule_date=schedule_date+'|'+'05:00 pm - 05:30 pm';
                                    });
                                  },
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: ColorStyle().color_gray),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: slot8?ColorStyle().color_red:ColorStyle().color_white
                                    ),
                                    height: 50,
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: new Center(
                                      child: new Text('05:00 pm - 05:30 pm',
                                        style: new TextStyle(fontSize: 14, color: slot8?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                    ),
                                  )
                                ))
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 8)),
                        new Row(
                          children: <Widget>[
                            new GestureDetector(
                              onTap: (){
                                setState(() {
                                  slot1=false;
                                  slot2=false;
                                  slot3=false;
                                  slot4=false;
                                  slot5=false;
                                  slot6=false;
                                  slot7=false;
                                  slot8=false;
                                  slot9=true;
                                  // schedule_date='';
                                  // schedule_date=schedule_date+'|'+'06:00 pm - 06:30 pm';
                                });
                              },
                              child: new Container(
                                width: MediaQuery.of(context).size.width/2.3,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: ColorStyle().color_gray),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: slot9?ColorStyle().color_red:ColorStyle().color_white
                                ),
                                height: 50,
                                margin: EdgeInsets.only(left: 5,right: 5),
                                child: new Center(
                                  child: new Text('06:00 pm - 06:30 pm',
                                    style: new TextStyle(fontSize: 14,color: slot9?ColorStyle().color_white:ColorStyle().color_dark_gray),),
                                ),
                              )
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
    _onLoading(false);
  }

  @override
  void onInserorderSuccess(AddToCart response) {
    // TODO: implement onInserorderSuccess
    _onLoading(false);
    if(response.value=="Error"){
      Fluttertoast.showToast(
          msg: "Order failed...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }else{
      Fluttertoast.showToast(
          msg: "Order placed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green[800],
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: HomeScreen()));
    }
  }

}
