import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/login.dart';
import 'package:flutter/material.dart';

abstract class LoginScreenContract {
  void onClientLoginSuccess(LoginData response);
  void onClientLoginError(String errorTxt);
}

class LoginScreenPresenter {

  LoginScreenContract _view;
  RestDataSource api = new RestDataSource();
  LoginScreenPresenter(this._view);

  getSignIn(String query) {
    api.clientSignin(query).then((LoginData res) {
      _view.onClientLoginSuccess(res);
    }).catchError((Object error) => _view.onClientLoginError(error.toString()));
  }

}