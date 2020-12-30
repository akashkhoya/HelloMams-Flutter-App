import 'dart:async';
import 'package:beinglearners/api/utils/network_util.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/get_all_order.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/model/product.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/model/comments/comment.dart';
import 'package:beinglearners/model/login.dart';
import 'package:beinglearners/model/signUp.dart';
import 'package:beinglearners/model/sub_category.dart';

class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = 'http://hellomams.com:36115';

  Future<LoginData> clientSignin(String query) {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    return _netUtil.post(BASE_URL+'/api/Account/signin', headers: headers,body: query).then((dynamic res) {
      return new LoginData.fromJson(res);
    });
  }

  Future<SignUpData> clientSignUp(String query) {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    return _netUtil.post(BASE_URL+'/api/Account/register', headers: headers,body: query).then((dynamic res) {
      return new SignUpData.fromJson(res);
    });
  }

  Future<SliderData> slider() {
    return _netUtil.get(BASE_URL+'/api/Account/GetSliders').then((dynamic res) {
      return new SliderData.fromJson(res);
    });
  }

  Future<CategoryData> categories() {
    return _netUtil.get(BASE_URL+'/api/Account/GetCategories').then((dynamic res) {
      return new CategoryData.fromJson(res);
    });
  }

  Future<ProductData> getTrendingProducts() {
    return _netUtil.get(BASE_URL+'/api/Account/GetTrendingProducts').then((dynamic res) {
      return new ProductData.fromJson(res);
    });
  }


  Future<SubCategoryData> subCategory(String cateId) {

    return _netUtil.get(BASE_URL+'/api/Account/GetSubCategoriesByCatID?CategoryID='+cateId,).then((dynamic res) {
      return new SubCategoryData.fromJson(res);
    });
  }

  Future<ProductData> product(String cateId,String subCateId) {

    return _netUtil.get(BASE_URL+'/api/Account/GetProductsBySubCatAndCatID?CategoryID='+cateId+'&SubCategoryID='+subCateId,).then((dynamic res) {
      return new ProductData.fromJson(res);
    });
  }

  Future<AddToCart> addToCart(String quantity,String productID,String token) {
    Map<String, String> headers = {
      "Authorization": 'Bearer '+token,
    };

    return _netUtil.post(BASE_URL+'/api/Account/AddToCart?productID='+productID+'&quantity='+quantity,headers: headers).then((dynamic res) {
      return new AddToCart.fromJson(res);
    });
  }

  Future<GetCartData> getCart(String token) {
    Map<String, String> headers = {
      "Authorization": 'Bearer '+token,
    };

    return _netUtil.post(BASE_URL+'/api/Account/GetCart',headers: headers).then((dynamic res) {
      return new GetCartData.fromJson(res);
    });
  }

  Future<AddToCart> getDeleteCart(String token,String cartID) {
    Map<String, String> headers = {
      "Authorization": 'Bearer '+token,
    };

    return _netUtil.post(BASE_URL+'/api/Account/DeleteCart?cartID='+cartID,headers: headers).then((dynamic res) {
      return new AddToCart.fromJson(res);
    });
  }

  Future<AddToCart> insertOrder(String query,String token) {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer '+token,
    };
    return _netUtil.post(BASE_URL+'/api/Account/InsertOrder', headers: headers,body: query).then((dynamic res) {
      return new AddToCart.fromJson(res);
    });
  }

  Future<AllOrderData> getAllOrder(String token,String oderID) {
    Map<String, String> headers = {
      "Authorization": 'Bearer '+token,
    };

    return _netUtil.get(BASE_URL+'/api/Account/GetAllMyOrders',headers: headers).then((dynamic res) {
      return new AllOrderData.fromJson(res);
    });
  }
}
