import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/signUp.dart';
import 'package:flutter/material.dart';

abstract class SignUpScreenContract {
  void onClientSignUpSuccess(SignUpData response);
  void onClientSignUpError(String errorTxt);
}

class SignUpScreenPresenter {

  SignUpScreenContract _view;
  RestDataSource api = new RestDataSource();
  SignUpScreenPresenter(this._view);

  getSignUp(String query) {
    api.clientSignUp(query).then((SignUpData res) {
      _view.onClientSignUpSuccess(res);
    }).catchError((Object error) => _view.onClientSignUpError(error.toString()));
  }

}