import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/get_all_order.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/model/login.dart';
import 'package:flutter/material.dart';

abstract class AllOrderScreenContract {
  
  void onAllOrderSuccess(AllOrderData response);
  void onAllOrderError(String errorTxt);
}

class AllOrderScreenPresenter {

  AllOrderScreenContract _view;
  RestDataSource api = new RestDataSource();
  AllOrderScreenPresenter(this._view);

  getAllOrder(String token,String orderID) {
    api.getAllOrder(token,orderID).then((AllOrderData res) {
      _view.onAllOrderSuccess(res);
    }).catchError((Object error) => _view.onAllOrderError(error.toString()));
  }
}