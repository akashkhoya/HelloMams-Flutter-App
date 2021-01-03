import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/screens/login_screen/login_screen.dart';
import 'package:beinglearners/screens/order_place_screen/order_place_screen.dart';
import 'package:beinglearners/screens/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkout_summary_screen_presenter.dart';

List<GetCartList> get_cart_List ;
bool loadingStatus =true;
int get_cart_listSize = 0 ;
int product_listSize = 0 ;
String click_id='';
double payable_amount=0;
String cart_id='';
String user_id='';

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
       _onLoading(true);
       _presenter.getCart(token);
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
        leading: new GestureDetector(
          onTap: (){
           Navigator.pop(context);
          },
          child: new Icon(Icons.keyboard_backspace,color: Colors.white,),
        ),
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
                child: new GestureDetector(
                  onTap: (){
                    if(get_cart_List.length==1){
                      Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: OrderPlaceScreen(
                          get_cart_List[0].id,get_cart_List[0].userID,payable_amount
                      )));
                    }else if(get_cart_List.length==2){
                      Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: OrderPlaceScreen(
                          (get_cart_List[0].id+','+get_cart_List[1].id+','),get_cart_List[0].userID,payable_amount
                      )));
                    }

                  },
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
                            child: new Text('Place order',
                              style: new TextStyle(color: ColorStyle().color_white,fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        ),

                      ],
                    ),
                  )
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
            child: new Image.asset('images/cartempty.png',width: 150,height: 150,),
          ),
        )
        :new Container(
      child: new ListView.builder(
        itemCount: get_cart_List.length,
          itemBuilder: (context,index){
            return new Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 4),
              height: 180,
              child: new Card(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width/3,
                      child: new Image.network(RestDataSource.BASE_URL+get_cart_List[index].productImage,fit: BoxFit.fill,),
                    ),
                   new Expanded(
                       child: new Container(
                         child: new Column(
                           children: <Widget>[
                             new Row(
                               children: <Widget>[
                                 new Container(
                                   width: MediaQuery.of(context).size.width/1.7,
                                   padding: EdgeInsets.only(top: 12,left: 8),
                                   child: new Text(get_cart_List[index].productTitle,
                                     style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 15,fontWeight: FontWeight.bold),
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
                                     style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 15),),
                                 ),
                                 new Container(
                                   padding: EdgeInsets.only(top: 8,left: 8),
                                   child: new Text(get_cart_List[index].productQuantity,
                                     style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14,fontWeight: FontWeight.bold),),
                                 )
                               ],
                             ),
                             new Row(
                               children: <Widget>[
                                 new Container(
                                   padding: EdgeInsets.only(top: 8,left: 8),
                                   child: new Text('servicePrice -',
                                     style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 15),),
                                 ),
                                 new Container(
                                   padding: EdgeInsets.only(top: 8,left: 8),
                                   child: new Text(get_cart_List[index].servicePrice.toString(),
                                     style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14,fontWeight: FontWeight.bold),),
                                 )
                               ],
                             ),
                             new Container(
                                 child: new Row(
                                   children: <Widget>[
                                     new Container(
                                       padding: EdgeInsets.only(top: 8,left: 8),
                                       child: new Text('TotalAmount -',
                                         style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 15),),
                                     ),
                                     new Container(
                                       padding: EdgeInsets.only(top: 8,left: 8),
                                       child: new Text(get_cart_List[index].totalAmount.toString(),
                                         style: new TextStyle(color: ColorStyle().color_dark_gray,fontSize: 14,fontWeight: FontWeight.bold),),
                                     )
                                   ],
                                 )
                             ),
                             new Row(
                               children: <Widget>[
                                 new GestureDetector(
                                     onTap: (){
                                       cart_id=get_cart_List[index].id;
                                       _onLoading(true);
                                       _presenter.getDelete(token,get_cart_List[index].id);
                                     },
                                     child: new Container(
                                       height: 30,
                                       width: 80,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.all(Radius.circular(6)),
                                         color: Colors.black26
                                       ),
                                       padding: EdgeInsets.only(left: 10),
                                       margin: EdgeInsets.only(top: 6),
                                       child: new Center(
                                         child: new Text('Remove',
                                           style: new TextStyle(color: ColorStyle().color_red,fontWeight: FontWeight.bold,fontSize: 13),),
                                       ),
                                     )
                                 )
                               ],
                             )
                           ],
                         ),
                       ))
                  ],
                ),

              ),
            );
          }),
    );
  }

  void logout(){
    shareprefe('false');
    Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: LoginPage()));
  }

  shareprefe(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('login_status', data);
  }


  @override
  void onGetCartError(String errorTxt) {
    // TODO: implement onGetCartError
    _onLoading(false);
    print(errorTxt);
    if(errorTxt=="Exception: 401"){
      Fluttertoast.showToast(
          msg: "Session has been expire Please login again..",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[800],
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: LoginPage()));
    }
  }

  @override
  void onGetCartSuccess(GetCartData response) {
    // TODO: implement onGetCartSuccess
    _onLoading(false);
    setState(() {
      get_cart_List =response.getCartList;
      get_cart_listSize =get_cart_List.length;
     setState(() {
       for(int i=0;i<get_cart_List.length;i++){
         payable_amount += get_cart_List[i].totalAmount;
       }

     });
    });
  }

  @override
  void onDeleteCartError(String errorTxt) {
    // TODO: implement onDeleteCartError
    _onLoading(false);

  }

  @override
  void onDeleteCartSuccess(AddToCart response) {
    // TODO: implement onDeleteCartSuccess
    _onLoading(false);
    setState(() {
      get_cart_List.removeWhere((item) => item.id == cart_id);
      get_cart_listSize =get_cart_List.length;
      payable_amount=0;
      for(int i=0;i<get_cart_List.length;i++){
        payable_amount += get_cart_List[i].totalAmount;
      }

    });
  }
}
