import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/get_all_order.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/model/login.dart';
import 'package:flutter/material.dart';

abstract class AllOrderDetailsScreenContract {
  
  void onAllOrderDetailsSuccess(AllOrderData response);
  void onAllOrderDetailsError(String errorTxt);
}

class AllOrderDetailsScreenPresenter {

  AllOrderDetailsScreenContract _view;
  RestDataSource api = new RestDataSource();
  AllOrderDetailsScreenPresenter(this._view);

  getAllOrder(String token,String orderID) {
    api.getAllOrderById(token,orderID).then((AllOrderData res) {
      _view.onAllOrderDetailsSuccess(res);
    }).catchError((Object error) => _view.onAllOrderDetailsError(error.toString()));
  }
}