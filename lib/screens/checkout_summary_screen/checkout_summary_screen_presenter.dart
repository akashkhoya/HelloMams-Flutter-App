import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/model/product.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/model/sub_category.dart';


abstract class CheckOutSummaryScreenContract {

  void onGetCartSuccess(GetCartData response);
  void onGetCartError(String errorTxt);

  void onDeleteCartSuccess(AddToCart response);
  void onDeleteCartError(String errorTxt);

}

class CheckOutSummaryScreenPresenter {

  CheckOutSummaryScreenContract _view;
  RestDataSource api = new RestDataSource();
  CheckOutSummaryScreenPresenter(this._view);


  getCart(String token) {
    api.getCart(token).then((GetCartData res) {
      _view.onGetCartSuccess(res);
    }).catchError((Object error) => _view.onGetCartError(error.toString()));
  }

  getDelete(String token,String cartID) {
    api.getDeleteCart(token,cartID).then((AddToCart res) {
      _view.onDeleteCartSuccess(res);
    }).catchError((Object error) => _view.onDeleteCartError(error.toString()));
  }
  
}