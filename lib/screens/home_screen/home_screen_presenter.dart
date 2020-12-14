import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/model/login.dart';
import 'package:flutter/material.dart';

abstract class HomeScreenContract {
  void onHomeDataSuccess(SliderData response);
  void onHomeDataError(String errorTxt);

  void onCategorySuccess(CategoryData response);
  void onCategoryError(String errorTxt);
}

class HomeScreenPresenter {

  HomeScreenContract _view;
  RestDataSource api = new RestDataSource();
  HomeScreenPresenter(this._view);

  getSliser() {
    api.slider().then((SliderData res) {
      _view.onHomeDataSuccess(res);
    }).catchError((Object error) => _view.onHomeDataError(error.toString()));
  }

  getCtegory() {
    api.categories().then((CategoryData res) {
      _view.onCategorySuccess(res);
    }).catchError((Object error) => _view.onCategoryError(error.toString()));
  }
}