import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/model/login.dart';



abstract class CheckOutSummaryScreenContract {

  void onInserorderSuccess(AddToCart response);
  void onInserorderError(String errorTxt);


}

class CheckOutSummaryScreenPresenter {

  CheckOutSummaryScreenContract _view;
  RestDataSource api = new RestDataSource();
  CheckOutSummaryScreenPresenter(this._view);


  getInsertOrder(String query,String token) {
    api.insertOrder(query,token).then((AddToCart res) {
      _view.onInserorderSuccess(res);
    }).catchError((Object error) => _view.onInserorderError(error.toString()));
  }
  
}