import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkout_summary_screen_presenter.dart';

List<GetCartList> get_cart_List ;
bool loadingStatus =true;
int get_cart_listSize = 0 ;
int product_listSize = 0 ;
String click_id='';
double payable_amount=0;

class CheckoutSummaryScreen extends StatefulWidget {

  @override
  _CheckoutSummaryScreenState createState() => _CheckoutSummaryScreenState();
}

class _CheckoutSummaryScreenState extends State<CheckoutSummaryScreen> implements CheckOutSummaryScreenContract {

  CheckOutSummaryScreenPresenter _presenter;

  _CheckoutSummaryScreenState() {
    _presenter = new CheckOutSummaryScreenPresenter(this);
  }
  String token;

  sharepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       token= prefs.getString('token');
       _presenter.getCart(token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
   sharepref();
   get_cart_List =new List();
   payable_amount=0;
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: ColorStyle().color_red,
        title: new Text('Summary'),
      ),
      body: widget_body(),
      bottomNavigationBar: new Container(
        height: 80,
        color: ColorStyle().color_red,
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(top: 15)),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(left: 20),
                            child: new Center(
                              child: new Text(' ₹ '+payable_amount.toString(),
                                style: new TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
                            )
                          ),
                        ],
                      ),
                      new Padding(padding: EdgeInsets.only(top: 8)),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(left: 20),
                            child: new Text('Amount Payable ',
                              style: new TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold,fontSize: 16),),
                          ),
                        ],
                      ),

                    ],
                  ),
                )),
            new Expanded(
              flex: 1,
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Colors.green
                        ),
                        child: new Center(
                          child: new Text('Checkout',
                          style: new TextStyle(color: ColorStyle().color_white,fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),

                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
  widget_body(){
    return get_cart_listSize==0?
        new Container(
          child: new Center(
            child: new Text('Data not found'),
          ),
        )
        :new Container(
      child: new ListView.builder(
        itemCount: get_cart_List.length,
          itemBuilder: (context,index){
            return new Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 4),
              height: 300,
              child: new Card(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: new Image.network(RestDataSource.BASE_URL+get_cart_List[index].productImage,fit: BoxFit.fill,),
                    ),
                   new Row(
                     children: <Widget>[
                       new Container(
                         padding: EdgeInsets.only(top: 12,left: 8),
                         child: new Text(get_cart_List[index].productTitle,
                         style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 16),),
                       )
                     ],
                   ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(top: 8,left: 8),
                          child: new Text('Quantity -',
                            style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        new Container(
                          padding: EdgeInsets.only(top: 8,left: 8),
                          child: new Text(get_cart_List[index].productQuantity,
                            style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
                        )
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(top: 8,left: 8),
                          child: new Text('servicePrice -',
                            style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        new Container(
                          padding: EdgeInsets.only(top: 8,left: 8),
                          child: new Text(get_cart_List[index].servicePrice.toString(),
                            style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
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
                                      style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 16,fontWeight: FontWeight.bold),),
                                  ),
                                  new Container(
                                    padding: EdgeInsets.only(top: 8,left: 8),
                                    child: new Text(get_cart_List[index].totalAmount.toString(),
                                      style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14),),
                                  )
                                ],
                              )
                            )),
                        new Expanded(
                            child: new GestureDetector(
                              onTap: (){
                                _presenter.getDelete(token,get_cart_List[index].id);
                              },
                              child: new Container(
                                child: new Center(
                                  child: new Text('Remove',
                                    style: new TextStyle(color: ColorStyle().color_red,fontWeight: FontWeight.bold,fontSize: 15),),
                                ),
                              )
                            ))
                      ],
                    )
                  ],
                ),

              ),
            );
          }),
    );
  }


  @override
  void onGetCartError(String errorTxt) {
    // TODO: implement onGetCartError
  }

  @override
  void onGetCartSuccess(GetCartData response) {
    // TODO: implement onGetCartSuccess
    setState(() {
      get_cart_List =response.getCartList;
      get_cart_listSize =get_cart_List.length;
     setState(() {
       payable_amount =get_cart_List[0].totalAmount;
     });
    });
  }

  @override
  void onDeleteCartError(String errorTxt) {
    // TODO: implement onDeleteCartError
  }

  @override
  void onDeleteCartSuccess(AddToCart response) {
    // TODO: implement onDeleteCartSuccess
    setState(() {
      get_cart_listSize =0;
      payable_amount=0;
    });
  }
}
