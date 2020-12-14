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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:shimmer/shimmer.dart';
import 'home_screen_presenter.dart';

bool loadingStatus =true;
bool cateLoadingStatus =true;

List<Value> slider_List ;
List<ListData> category_List ;
bool appBarStatus =true;
int bgColor =0;
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
  bool status = false;
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
                        dialogs('Are You Logout');
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
          padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height/4,bottom: MediaQuery.of(context).size.height/4),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            content:  new Container(
                child: new Center(
                    child: new Column(
                      children: <Widget>[
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/logo_transparent.png')
                              )
                          ),
                          // child: new Image.asset('images/logo_transparent.png',),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                padding: EdgeInsets.only(top: 0,bottom: 10),
                                width:200,
                                child: new Center(
                                  child: new Text(mesg,
                                    style: new TextStyle(color: new ColorStyle().color_royal_blue,fontSize: 17,fontWeight: FontWeight.bold),),
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
  void logout(){
    new SharedPreferencesClass().setloginstatus(false);
    Navigator.pushReplacement(context, PageTransition(type:PageTransitionType.custom, duration: Duration(seconds: 0), child: LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: new Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: new ColorStyle().color_red,
        title: new Container(
          padding: EdgeInsets.only(left: 10),
          child: new Text('Dashboard', textAlign: TextAlign.start,
            style: new TextStyle(color: new ColorStyle().color_white,
                fontSize: 20.0 ,fontWeight: FontWeight.bold),),
        ),

        actions: <Widget>[
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
            new Container(
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
            ),
            new Container(
              height: 230,
              child: new ListView.builder(
                  itemCount: slider_listSize,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return  new Container(
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
                    );
                  }),
            ),
            new Container(
                height: 400,
                padding: EdgeInsets.only(bottom: 30),
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
                            child: new Container(
                                decoration: new BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(7)),
                                  child: Image.network(RestDataSource.BASE_URL+category_List[index].categoryIMG),
                                )

                            )
                        ),
                      )
                    );
                  }),
                ),
            )

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


