import 'dart:io';
import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/common/colors.dart';
import 'package:beinglearners/common/constant.dart';
import 'package:beinglearners/common/shared_preferences.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/screens/edit_profile/edit_profile.dart';
import 'package:beinglearners/screens/login_screen/login_screen.dart';
import 'package:beinglearners/screens/product_screen/product_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'home_screen_presenter.dart';

bool loadingStatus =true;
bool cateLoadingStatus =true;

List<Value> slider_List ;
List<ListData> category_List ;
bool appBarStatus =true;
int bgColor =0;
int _current = 0;
int _current_index = 0;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeScreenContract {

  HomeScreenPresenter _presenter;
  int slider_listSize = 0 ;
  int category_listSize = 0 ;
  String _email="";
  String name="";
  String status = 'false';
  String category_name ='';
  String category_id ='';

  List<String> image_list =['images/m1.jpg','images/m2.jpg','images/m3.jpg','images/m4.jpg','images/m5.jpg'];
  List<String> grid_list =['images/b1.jpg','images/b2.jpg','images/b3.jpg','images/b4.jpg','images/b5.jpg','images/b6.jpg','images/b7.jpeg'];

  _HomeScreenState() {
    _presenter = new HomeScreenPresenter(this);
  }

  void getprofile() async{
    status=await new SharedPreferencesClass().getloginstatus();
    _email=await new SharedPreferencesClass().getEmail();
    name=await new SharedPreferencesClass().getName();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarStatus =true;
    getprofile();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
    ));
    setState(() {
      loadingStatus =true;
      cateLoadingStatus =true;
      bgColor =0;
      slider_listSize=0;
      category_listSize=0;
    });
    _presenter.getSliser();

  }

  Widget drawer() {
    return Container(
      width: MediaQuery.of(context).size.width/1.4,
      child: Drawer(
          child:  new Container(
            color: ColorStyle().color_white,
            child: Column(
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 25),
                  height: 100,
                  child: new Image.asset('images/logo.jpeg',width: 50,height: 50,),
                ),
                new Padding(padding: EdgeInsets.only(top: 15)),
                new Container(
                  child: new Center(
                    child: new Text('Welcome',
                    style: new TextStyle(fontSize: 16),),
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 15)),
                new Container(
                  height: 2,
                  color: ColorStyle().color_black,
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: Text("Home",
                        style: new TextStyle(color: new ColorStyle().color_black,fontSize: 16),),
                      leading: Icon(Icons.home),
                      onTap: (){
//                        status==null||status==false?Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: LoginPage())):
                        Navigator.pop(context);

                      },
                    ),
                    ListTile(
                      title: Text("Edit Profile",
                        style: new TextStyle(color: new ColorStyle().color_black,fontSize: 16),),
                      leading: Icon(Icons.edit),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: EditProfileScreen()));
                      },
                    ),

                    ListTile(
                      title: Text("Setting",
                        style: new TextStyle(color: new ColorStyle().color_black,fontSize: 16),),
                      leading: Icon(Icons.settings),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      title: Text("About us",
                        style: new TextStyle(color: new ColorStyle().color_black,fontSize: 16),),
                      leading: Icon(Icons.ac_unit),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    status==null||status==false?new Container():ListTile(
                      title: Text("Logout",
                        style: new TextStyle(color: new ColorStyle().color_black,fontSize: 16),),
                      leading: Icon(Icons.power_settings_new),
                      onTap: (){
                        Navigator.pop(context);
                        dialogs('Are you sure you want to log out?');
                      },
                    ),

                  ],
                ),

              ],
            ),
          )
      ),
    );
  }

  void dialogs(String mesg) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height/3,bottom: MediaQuery.of(context).size.height/3),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            content:  new Container(
                child: new Center(
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                padding: EdgeInsets.only(top: 0,bottom: 10),
                                width:200,
                                child: new Center(
                                  child: new Text(mesg,
                                    style: new TextStyle(color: new ColorStyle().color_royal_blue,fontSize: 17,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,),
                                )
                            )
                          ],
                        ),
                        new Padding(padding: EdgeInsets.only(top: 10)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: new Container()
                            ),
                            Expanded(
                              flex: 2,
                              child:  Padding(
                                padding: new EdgeInsets.only(left: 20),
                                child: new InkWell(
                                  onTap: (){
                                    logout();
                                  },
                                  child: new Container(

                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: ColorStyle().color_red,
                                        borderRadius: BorderRadius.all(Radius.circular(6))
                                    ),

                                    child: Center(
                                      child: Text("OK",style: TextStyle(color: ColorStyle().color_white),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            new Container(width: 10,),
                            new Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: new EdgeInsets.only(right: 20),
                                  child: new InkWell(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: new Container(
                                      height: 30,
                                      padding: EdgeInsets.only(left: 6,right: 6),
                                      decoration: BoxDecoration(
                                          color: ColorStyle().color_red,
                                          borderRadius: BorderRadius.all(Radius.circular(6))
                                      ),

                                      child: Center(
                                        child: Text("Cancel",style: TextStyle(color: ColorStyle().color_white),),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: new Container()
                            ),
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

  sharepref(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('login_status', data);
  }

  void logout(){
    sharepref('false');
    Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: new Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: new ColorStyle().color_red,
        title: new Container(
          padding: EdgeInsets.only(left: 10),
          child: new Text('Dashboard', textAlign: TextAlign.start,
            style: new TextStyle(color: new ColorStyle().color_white,
                fontSize: 20.0 ,fontWeight: FontWeight.bold),),
        ),

        actions: <Widget>[
          new SizedBox(
            height: 30,
            child: new Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: new Center(
                  child: new Icon(Icons.account_circle,size: 27,),
                )
            )
          ),
          IconButton(
            icon: Icon(Icons.search,
              color: new ColorStyle().color_white,
            ),
            onPressed: () {
              setState(() {
                appBarStatus =false;
              });
            },
          ),
        ],
      ),
      drawer: drawer(),
      body: widget_body(),
          bottomNavigationBar: new Container(
            height: 60,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black54,
             borderRadius: BorderRadius.all(Radius.circular(7))
            ),
            width: MediaQuery.of(context).size.width,
            child: new Center(
              child: new Text('Welcome to Hello mams',
              style: new TextStyle(fontSize: 19,color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
            )
          ),
    ),
    );
  }

  widget_body(){

    return loadingStatus==true?new Container(
      color: Colors.white,
      child: new Center(
        child: new Image.asset('images/loading_img.gif'),
      ),
    ):new Container(
        color: new ColorStyle().color_white,
        child: new ListView(
          children: <Widget>[
           /* new Container(
              height: 40,
              color: new ColorStyle().color_red,
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        child: new Icon(Icons.location_on,color: ColorStyle().color_white,),
                      ),
                      new Container(
                        padding: EdgeInsets.only(left: 7),
                        child: new Text('8,Block A, Ashok Vihar Gurgaon',
                        style: new TextStyle(color: ColorStyle().color_white,fontSize: 15),),
                      )
                    ],
                  )
                ],
              ),
            ),*/
            new Container(
              height: 200,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  viewportFraction: 1.0,
                ),
                items: slider_List.map((item){
                  return Container(
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: new Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                margin: EdgeInsets.all(5),
                                elevation: 5,
                                child: new ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: new Image.network(RestDataSource.BASE_URL+item.sliderImg,fit: BoxFit.fill,),
                                )
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.black26,
                            ),
                          ),
                          new Container(
                              margin: EdgeInsets.only(left: 5,top: 155,bottom: 5,right: 5),
                              height: 45,
                              width: MediaQuery.of(context).size.width/1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(15)),
                                color: Colors.black26,
                              ),
                              child: new Center(
                                  child: new Text(item.sliderName,
                                    style: new TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold,fontSize: 17),)
                              )
                          ),
                        ],
                      )
                  );
                }
                ).toList(),
              ),
              /*child: new ListView.builder(
                  itemCount: slider_listSize,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return  new Stack(
                      children: <Widget>[
                        new Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width/1.2,
                          child: new Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: EdgeInsets.all(10),
                              elevation: 5,
                              child: new ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: new Image.network(RestDataSource.BASE_URL+slider_List[index].sliderImg,fit: BoxFit.fill,),
                              )
                          ),
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width/1.27,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.black54,
                          ),

                          child: new Center(
                            child: new Text(slider_List[index].sliderName,
                            style: new TextStyle(color: ColorStyle().color_white,fontWeight: FontWeight.bold,fontSize: 17),)
                          ),
                        )
                      ],
                    );
                  }),*/
            ),

            new Container(
                height: 270,
                padding: EdgeInsets.only(bottom: 5),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3 ,
                  children: List.generate(category_listSize,(index){
                    return  new InkWell(
                      onTap: (){
                        category_name =category_List[index].categoryName;
                        category_id =category_List[index].id;
                        Navigator.push(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: ProductScreen(category_name,
                            category_id)));
                      },
                      child: Container(
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.blue,
                            child: new Stack(
                              children: <Widget>[
                                new Container(
                                  height: 200,
                                    decoration: new BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.all(Radius.circular(8))
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(7)),
                                      child: Image.network(RestDataSource.BASE_URL+category_List[index].categoryIMG,
                                        fit: BoxFit.fill,),
                                    )

                                ),
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: new BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  child: new Column(
                                    children: <Widget>[
                                      new Expanded(
                                        flex: 2,
                                        child: new Row(
                                          children: <Widget>[
                                            new Container(
                                              decoration: BoxDecoration(
                                                  // color: Color(0xffa8d7ec),
                                                  color: Colors.black26
                                              ),
                                              padding: EdgeInsets.only(left: 4,top: 3,bottom: 3,right: 12),
                                              child: new Text(category_List[index].categoryType,
                                                style: new TextStyle(fontSize: 10,color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // new Padding(padding: EdgeInsets.only(top: 60)),
                                      new Expanded(
                                          flex: 4,
                                          child: new Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  color: Colors.black26
                                                ),
                                                padding: EdgeInsets.only(left: 4),
                                                child: new Center(
                                                  child: new Text(category_List[index].categoryCost+'/'+category_List[index].categoryDuration,
                                                    style: new TextStyle(fontSize: 9,color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
                                                )
                                              )
                                            ],
                                          )
                                      ),
                                      new Expanded(
                                        flex: 2,
                                          child: new Container(
                                            color: Colors.black26,
                                            padding: EdgeInsets.only(left: 4),
                                            child: new Center(
                                              child: new Text(category_List[index].categoryName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: new TextStyle(fontSize: 11,color: ColorStyle().color_white,fontWeight: FontWeight.bold),),
                                            )
                                          ),),

                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    );
                  }),
                ),
            ),

            new Container(
              height: 200,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  viewportFraction: 1.0,
                ),
                items: slider_List.map((item){
                  return Container(
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: new Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                ),
                                margin: EdgeInsets.only(left: 5,right:5,top: 5),
                                elevation: 5,
                                child: new ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                  child: new Image.network(RestDataSource.BASE_URL+item.sliderImg,fit: BoxFit.fill,),
                                )
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 5,right:5,top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                              color: Colors.black26,
                            ),
                            child:  new Container(
                              height: 50,
                              margin: EdgeInsets.only(top: 145),
                              child: new Card(
                                  child: new Row(
                                    children: <Widget>[
                                      new Expanded(
                                        flex: 6,
                                        child: new Container(
                                            height: 45,
                                            padding: EdgeInsets.only(top: 10,left: 10),
                                            width: MediaQuery.of(context).size.width/1,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(15)),
                                            ),
                                            child: new Text('Express Waxing',
                                              style: new TextStyle(color: ColorStyle().color_black,fontWeight: FontWeight.bold,fontSize: 17),)
                                        ),
                                      ),
                                      new Expanded(
                                          flex: 3,
                                          child:new Row(
                                            children: <Widget>[
                                              new Container(
                                                  height: 45,
                                                  padding: EdgeInsets.only(top: 10,left: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(15)),
                                                  ),
                                                  child: new Text('₹ 824/-',
                                                    style: new TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 17),)
                                              ),
                                              new Container(
                                                  height: 45,
                                                  padding: EdgeInsets.only(top: 13,left: 3),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(15)),
                                                  ),
                                                  child: new Text('(65 min)',
                                                    style: new TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12),)
                                              ),
                                            ],
                                          )
                                      )
                                    ],
                                  )
                              ),
                            )
                          ),
                        ],
                      )
                  );
                }
                ).toList(),
              ),
            ),
          ],
        )
    );

  }


  @override
  void onHomeDataError(String errorTxt) {
    // TODO: implement onHomeDataError
  }

  @override
  void onHomeDataSuccess(SliderData response) {
    // TODO: implement onHomeDataSuccess
    setState(() {
      slider_List =response.sliderList;
      slider_listSize =slider_List.length;
      _presenter.getCtegory();
    });
  }

  @override
  void onCategoryError(String errorTxt) {
    // TODO: implement onCategoryError
    loadingStatus=false;
  }

  @override
  void onCategorySuccess(CategoryData response) {
    // TODO: implement onCategorySuccess
    loadingStatus=false;
    setState(() {
      category_List =response.categoryList;
      category_listSize =category_List.length;
    });
  }

}


