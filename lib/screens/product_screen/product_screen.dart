import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/model/product.dart';
import 'package:beinglearners/model/sub_category.dart';
import 'package:beinglearners/screens/checkout_summary_screen/checkout_summary_screen.dart';
import 'package:beinglearners/screens/product_screen/product_screen_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<SubCateData> sub_cate_List ;
List<ProductDescriptions> product_description_List ;
bool loadingStatus =true;
int sub_cate_listSize = 0 ;
int product_listSize = 0 ;
String click_id='';
int total_amount=0;
int total_item=0;
int total_time=0;


class ProductScreen extends StatefulWidget {
  String category_name,category_id;
  ProductScreen(this.category_name,this.category_id);
  @override
  _ProductScreenState createState() => _ProductScreenState();
  static _ProductScreenState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_ProductScreenState>());
}

class _ProductScreenState extends State<ProductScreen> implements ProductScreenContract {

  ProductScreenPresenter _presenter;

  _ProductScreenState() {
    _presenter = new ProductScreenPresenter(this);
  }

  sharepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      TOKEN= prefs.getString('token');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    sharepref();
    _presenter.getSubCategory(widget.category_id);
     loadingStatus =true;
     setState(() {
       sub_cate_listSize = 0 ;
       product_listSize = 0 ;
       add_to_cart_count=0;
       total_item=0;
       total_time=0;
       total_amount=0;
     });
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: ColorStyle().color_red,
        title: new Text(widget.category_name),
        actions: <Widget>[
          new GestureDetector(
            onTap: (){
              Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: CheckoutSummaryScreen()));
            },
            child:new Stack(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(right: 20,top: 15),
                  child: new Icon(Icons.shopping_cart,color: ColorStyle().color_white,size: 30,),
                ),
                new Container(
                    margin: EdgeInsets.only(left: 20,top: 10),
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: ColorStyle().color_white,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: new Center(
                      child: new Text(add_to_cart_count.toString(),
                        style: TextStyle(color: ColorStyle().color_black,fontSize: 8,fontWeight: FontWeight.bold),),
                    )
                )
              ],
            )
          )

        ],
      ),
      body: widget_body(),
      bottomNavigationBar: new Container(
        height: 100,
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
                            child: new Text('Total Amount:',
                              style: new TextStyle(color: ColorStyle().color_black,fontWeight: FontWeight.bold),),
                          ),
                          new Container(
                            child: new Text(' ₹ '+total_amount.toString(),
                            style: new TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      new Padding(padding: EdgeInsets.only(top: 8)),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(left: 20),
                            child: new Text('Total Items: ',
                              style: new TextStyle(color: ColorStyle().color_black,fontWeight: FontWeight.bold),),
                          ),
                          new Container(
                            child: new Text(total_item.toString(),
                              style: new TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      new Padding(padding: EdgeInsets.only(top: 8)),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(left: 20),
                            child: new Text('Total Times:',
                              style: new TextStyle(color: ColorStyle().color_black,fontWeight: FontWeight.bold),),
                          ),
                          new Container(
                            child: new Text(total_time.toString()+'  min',
                              style: new TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            new Expanded(
              flex: 1,
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                     new GestureDetector(
                       onTap: (){
                         if(total_item==0){

                         }else{
                           // _presenter.getAddToCart(product_count.toString(),product_List[widget.position].id,TOKEN);
                           Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: CheckoutSummaryScreen()));
                         }

                       },
                       child:  new Container(
                         margin: EdgeInsets.only(top: 15),
                         height: 40,
                         width: 150,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(6)),
                             color: total_item==0?ColorStyle().color_gray_light:Colors.green
                         ),
                         child: new Center(
                           child: new Text('Checkout',
                             style: new TextStyle(color: ColorStyle().color_white,fontSize: 18,fontWeight: FontWeight.bold),),
                         ),
                       ),
                     ),
                      new Container(
                        margin: EdgeInsets.only(top: 5),
                        child:  new Text('Min. Checkout Time is 50 mins',
                          style: new TextStyle(color: ColorStyle().color_black,fontSize: 12,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
  widget_body(){
    return new Container(
      child: new Column(
        children: <Widget>[
          sub_cate_listSize==0?new Container():new Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            color:ColorStyle().color_red,
            child: new Container(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: new ListView.builder(
                  itemCount: sub_cate_List.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return new GestureDetector(
                        onTap: (){
                          setState(() {
                            click_id =sub_cate_List[index].id;
                          });
                          loadingStatus=true;
                          _presenter.getProduct(sub_cate_List[index].categoryID,sub_cate_List[index].id);
                        },
                        child: new Container(
                            height: 25,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: click_id==sub_cate_List[index].id?
                            new Card(
                                elevation: 7,
                                color: ColorStyle().color_red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: new Container(
                                  padding: EdgeInsets.only(left: 16,right: 16),
                                  child: new Center(
                                    child: new Text(sub_cate_List[index].subCategoryName,
                                      style: new TextStyle(color: ColorStyle().color_white,
                                          fontSize: 16,fontWeight: FontWeight.bold),),
                                  ),
                                )
                            ):
                            new Container(
                              child: new Center(
                                child: new Text(sub_cate_List[index].subCategoryName,
                                  style: new TextStyle(color: ColorStyle().color_white,
                                      fontSize: 16,fontWeight: FontWeight.bold),),
                              ),
                            )
                        )
                    );
                  }),
            )
          ),

          new Expanded(
            child: loadingStatus?new Container(
              height: MediaQuery.of(context).size.height/1.53,
              color: Colors.white,
              child: new Center(
                child: new Image.asset('images/loading_img.gif'),
              ),
            ):new Container(
                child: product_listSize==0?new Container(
                  color: ColorStyle().color_white,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height: 100,
                        color: Colors.white,
                        child: new Image.asset('images/data_not_found.gif',width: 60,height: 60,),
                      ),
                      new Container(
                        child: new Center(
                          child: new Text('Result not found',
                            style: new TextStyle(color: ColorStyle().color_red,fontWeight: FontWeight.bold,fontSize: 18),),
                        ),
                      )
                    ],
                  )
                ):new ListView.builder(
                    itemCount: product_List.length,
                    itemBuilder: (context,index){
                      // total_time=int.parse(product_List[index].minimumServiceTime);
                      return new ListItems(index);
                    })
            )
          )
        ],
      ),
    );
  }

  @override
  void onProdctSuccess(SubCategoryData response) {
    // TODO: implement onProdctSuccess
    loadingStatus=false;
    setState(() {
      sub_cate_List =response.sub_categoryList;
      sub_cate_listSize =sub_cate_List.length;
      if(sub_cate_listSize>0){
        setState(() {
          click_id=sub_cate_List[0].id;
        });
        _presenter.getProduct(sub_cate_List[0].categoryID,sub_cate_List[0].id);
      }

    });
  }

  @override
  void onProductError(String message) {
    loadingStatus= false;
    // TODO: implement onProductError

  }

  @override
  void onProdctDataSuccess(ProductData response) {
    // TODO: implement onProdctDataSuccess
    loadingStatus=false;
    setState(() {
      product_List =response.productList;
      product_listSize =product_List.length;
    });
    _presenter.getCart(TOKEN);

  }

  @override
  void onProductDataError(String error) {
    // TODO: implement onProductDataError
    loadingStatus=false;
   setState(() {
     product_listSize=0;
     _presenter.getCart(TOKEN);
   });
  }

  @override
  void onAddToCartError(String errorTxt) {
    // TODO: implement onAddToCartError
  }

  @override
  void onAddToCartSuccess(AddToCart response) {
    // TODO: implement onAddToCartSuccess
    if(response.value!=null){
      String message =response.value;
      print(message);
      _presenter.getCart(TOKEN);

    }
  }

  @override
  void onGetCartError(String errorTxt) {
    // TODO: implement onGetCartError
  }

  @override
  void onGetCartSuccess(GetCartData response) {
    // TODO: implement onGetCartSuccess
   setState(() {
     add_to_cart_count =response.getCartList.length;
   });
  }

  @override
  void onDeleteCartError(String errorTxt) {
    // TODO: implement onDeleteCartError
  }

  @override
  void onDeleteCartSuccess(AddToCart response) {
    // TODO: implement onDeleteCartSuccess
  }
}

class ListItems extends StatefulWidget {
  int position;
  ListItems(this.position);
  @override
  _ListItemsState createState() => _ListItemsState();
  static _ListItemsState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_ListItemsState>());
}

class _ListItemsState extends State<ListItems> implements ProductScreenContract {

  ProductScreenPresenter _presenter;

  _ListItemsState() {
    _presenter = new ProductScreenPresenter(this);
  }

  bool card_visivility = true;
  int product_count=0;

  @override
  void initState() {
    // TODO: implement initState
      setState(() {
        card_visivility =true;
        product_count=0;
      });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: 6,right: 6,top: 5),
      child: new Card(
        elevation: 12,
        child: new Column(
          children: <Widget>[
            new Container(
              height: 200,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new Container(
                      child: new ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: new Image.network(RestDataSource.BASE_URL+product_List[widget.position].productImg),
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.only(top: 10,left: 12),
                            child: new Text(product_List[widget.position].productTitle,
                              style: new TextStyle(color: ColorStyle().color_black,fontWeight: FontWeight.bold,
                                  fontSize: 16),),
                          ),
                          new Row(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(top: 10,left: 12),
                                child: new Text('₹ '+product_List[widget.position].productPrice+'/-',
                                  style: new TextStyle(color: Colors.green,
                                      fontSize: 18),),
                              ),
                              new Stack(
                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.only(top: 10,left: 12),
                                    child: new Text('₹ '+product_List[widget.position].productStandardPrice,
                                      style: new TextStyle(color: Colors.black,
                                          fontSize: 16),),
                                  ),
                                  new Container(
                                    margin: EdgeInsets.only(left:8,top: 20),
                                    height: 1,
                                    width: 60,
                                    color: ColorStyle().color_black,
                                  ),
                                ],
                              )
                            ],
                          ),
                          new Container(
                            padding: EdgeInsets.only(top: 10),
                            child: new Text('0% off',
                              style: new TextStyle(color: ColorStyle().color_black,
                                  fontSize: 15),),
                          ),
                          new Row(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(top: 10,left: 15),
                                child: new Text('L',
                                  style: new TextStyle(color: ColorStyle().color_black,
                                      fontSize: 15),),
                              ),
                              new Container(
                                padding: EdgeInsets.only(top: 10,left: 15),
                                child: new Text(product_List[widget.position].minimumServiceTime,
                                  style: new TextStyle(color: ColorStyle().color_black,
                                      fontSize: 15),),
                              ),
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              card_visivility?new GestureDetector(
                                onTap: (){
                                  ProductScreen.of(context).setState(() {
                                    product_count=1;
                                    // add_to_cart_count=0;
                                    total_item=1;
                                    total_amount=int.parse(product_List[widget.position].productStandardPrice);
                                    card_visivility =false;

                                    String des =product_List[widget.position].minimumServiceTime;
                                    var part = des.split('min');
                                    total_time =int.parse(part[0]);
                                    _presenter.getAddToCart(product_count.toString(),product_List[widget.position].id,TOKEN);
                                  });
                                },
                                child: new Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(6)),
                                      color: ColorStyle().color_red
                                  ),
                                  child: new Center(
                                      child: new Text('Add to cart',
                                        style: TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold),)
                                  ),
                                ),
                              ):
                              new Row(
                                children: <Widget>[
                                  new GestureDetector(
                                    onTap: (){
                                      ProductScreen.of(context).setState(() {
                                        if(product_count>1){
                                          product_count--;
                                          // add_to_cart_count=0;
                                          total_item=product_count;
                                          total_amount=int.parse(product_List[widget.position].productStandardPrice)*product_count;
                                          total_time =total_time*product_count;
                                          _presenter.getDelete(TOKEN,product_List[widget.position].id);
                                        }else{
                                          setState(() {
                                            // add_to_cart_count=0;
                                            total_item=0;
                                            total_amount=0;
                                            total_time=0;
                                            card_visivility =true;
                                          });
                                        }
                                      });
                                    },
                                    child: new Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                          color: ColorStyle().color_red
                                      ),
                                      child: new Center(
                                          child: new Icon(Icons.remove,size: 22,color: ColorStyle().color_white,)
                                      ),
                                    ),
                                  ),
                                  new GestureDetector(
                                    child: new Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 30,
                                      width: 40,
                                      child: new Center(
                                        child: new Text(product_count.toString(),
                                          style: new TextStyle(color: ColorStyle().color_black,fontWeight: FontWeight.bold,fontSize: 18),),
                                      ),
                                    ),
                                  ),
                                  new GestureDetector(
                                    onTap: (){
                                      ProductScreen.of(context).setState(() {
                                        product_count++;
                                        // add_to_cart_count=1;
                                        total_item=product_count;
                                        total_amount=int.parse(product_List[widget.position].productStandardPrice)*product_count;
                                        total_time =total_time*product_count;
                                        _presenter.getAddToCart(product_count.toString(),product_List[widget.position].id,TOKEN);
                                      });
                                    },
                                    child: new Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                          color: ColorStyle().color_red
                                      ),
                                      child: new Center(
                                          child: new Icon(Icons.add,size: 22,color: ColorStyle().color_white,)
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            product_List[widget.position].productDescriptionsList.length==0?new Container(): new Container(
              height: 90,
              child: new ListView.builder(
                  itemCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,pIndex){
                    String des =product_List[0].productDescriptionsList[pIndex].descriptions;
                    var parts = des.split('#');
                    return new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(top: 5,left: 10),
                          child: new Text('● '+parts[0],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,),
                        ),
                        new Container(
                          padding: EdgeInsets.only(top: 5,left: 10),
                          child: new Text( '● '+parts[1],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,),
                        ),
                        new Container(
                          padding: EdgeInsets.only(top: 5,left: 10),
                          child: new Text( '● '+parts[2],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onAddToCartError(String errorTxt) {
    // TODO: implement onAddToCartError
  }

  @override
  void onAddToCartSuccess(AddToCart response) {
    // TODO: implement onAddToCartSuccess
    if(response.value!=null){
      String message =response.value;
      print(message);
      // _presenter.getCart(TOKEN);

    }
  }

  @override
  void onGetCartError(String errorTxt) {
    // TODO: implement onGetCartError
  }

  @override
  void onGetCartSuccess(GetCartData response) {
    // TODO: implement onGetCartSuccess
  }

  @override
  void onProdctDataSuccess(ProductData response) {
    // TODO: implement onProdctDataSuccess
  }

  @override
  void onProdctSuccess(SubCategoryData response) {
    // TODO: implement onProdctSuccess
  }

  @override
  void onProductDataError(String errorTxt) {
    // TODO: implement onProductDataError
  }

  @override
  void onProductError(String errorTxt) {
    // TODO: implement onProductError
  }

  @override
  void onDeleteCartError(String errorTxt) {
    // TODO: implement onDeleteCartError
  }

  @override
  void onDeleteCartSuccess(AddToCart response) {
    // TODO: implement onDeleteCartSuccess
  }
}
