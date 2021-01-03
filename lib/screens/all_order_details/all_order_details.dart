import 'dart:ui';
import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/model/get_all_order.dart';
import 'package:beinglearners/screens/all_order/all_order_screen_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'all_order_details_screen_presenter.dart';

List<AllOrderDataList> all_order_details_List ;
List<CartOrdersList> cart_data_details_List ;
int list_size=0;
class AllOrderDetailsScreen extends StatefulWidget {
  String id ;
  AllOrderDetailsScreen(this.id);
  @override
  _AllOrderDetailsScreenState createState() => _AllOrderDetailsScreenState();
}

class _AllOrderDetailsScreenState extends State<AllOrderDetailsScreen> implements AllOrderDetailsScreenContract {

  AllOrderDetailsScreenPresenter _presenter;
  String token='';

  _AllOrderDetailsScreenState() {
    _presenter = new AllOrderDetailsScreenPresenter(this);
  }

  sharepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token= prefs.getString('token');
      _onLoading(true);
      _presenter.getAllOrder(token, widget.id);
    });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharepref();
    all_order_details_List =new List();
    cart_data_details_List =new List();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),

      ),
      body: all_order_details_List==0?
          new Container(
            child: new Center(
              child: new Text('Order Data not found',
              style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 18,fontWeight: FontWeight.bold),),
            ),
          )
          :new Container(
        height: MediaQuery.of(context).size.height,
        child: new ListView.builder(
          itemCount: all_order_details_List.length,
            itemBuilder: (context,index){
              return  new Card(
                elevation: 10,
                child: new Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 4),
                  height: MediaQuery.of(context).size.height,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width/3,
                        child: new Image.network(RestDataSource.BASE_URL+all_order_details_List[index].cartOrdersList[0].productImage,fit: BoxFit.fill,),
                      ),
                      new Expanded(
                          child: new Container(
                              child: new Column(
                                children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      new Container(
                                        width: MediaQuery.of(context).size.width/1.1,
                                        padding: EdgeInsets.only(top: 12,left: 8),
                                        child: new Text(all_order_details_List[index].cartOrdersList[0].productTitle,
                                          style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14,fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,),
                                      )
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Container(
                                        padding: EdgeInsets.only(top: 8,left: 8),
                                        child: new Text('Quantity -',
                                          style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
                                      ),
                                      new Container(
                                        padding: EdgeInsets.only(top: 8,left: 8),
                                        child: new Text(all_order_details_List[index].cartOrdersList[0].productQuantity,
                                          style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14,fontWeight: FontWeight.bold),),
                                      )
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          child: new Container(
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 8,left: 8),
                                                    child: new Text('TotalAmount -',
                                                      style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
                                                  ),
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 8,left: 8),
                                                    child: new Text(all_order_details_List[index].cartOrdersList[0].totalAmount.toString(),
                                                      style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14,fontWeight: FontWeight.bold),),
                                                  )
                                                ],
                                              )
                                          )),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          child: new Container(
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 4,left: 8),
                                                    child: new Text('Status -',
                                                      style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
                                                  ),
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 8,left: 8),
                                                    child: new Text(all_order_details_List[index].orderStatus,
                                                      style: new TextStyle(color:Colors.green[800],fontSize: 12,fontWeight: FontWeight.bold),),
                                                  )
                                                ],
                                              )
                                          )),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          child: new Container(
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 4,left: 8),
                                                    child: new Text('Payment Mode -',
                                                      style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
                                                  ),
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 8,left: 8),
                                                    child: new Text(all_order_details_List[index].paymentMethod,
                                                      style: new TextStyle(color:Colors.green[800],fontSize: 12,fontWeight: FontWeight.bold),),
                                                  )
                                                ],
                                              )
                                          )),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          child: new Container(
                                              child: new Row(
                                                children: <Widget>[
                                                  new Container(
                                                    padding: EdgeInsets.only(top: 4,left: 8),
                                                    child: new Text('Address -',
                                                      style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
                                                  ),
                                                  new Container(
                                                    width: MediaQuery.of(context).size.width/1.4,
                                                    padding: EdgeInsets.only(top: 8,left: 8),
                                                    child: new Text(all_order_details_List[index].address,
                                                      style: new TextStyle(color:Colors.black54,fontSize: 13,fontWeight: FontWeight.bold),),
                                                  )
                                                ],
                                              )
                                          )),
                                    ],
                                  )
                                ],
                              )
                          ))

                    ],
                  ),
                )
              );
            }),
      )
    );
  }
  

  @override
  void onAllOrderDetailsError(String errorTxt) {
    // TODO: implement onAllOrderDetailsError
    _onLoading(false);
  }

  @override
  void onAllOrderDetailsSuccess(AllOrderData response) {
    // TODO: implement onAllOrderDetailsSuccess
    _onLoading(false);
    setState(() {
      if(response.allOrderDataList!=0){
        all_order_details_List= response.allOrderDataList;
        list_size=all_order_details_List.length;
        cart_data_details_List =response.allOrderDataList[0].cartOrdersList;
      }else{
        list_size=0;
      }

    });
  }
}
