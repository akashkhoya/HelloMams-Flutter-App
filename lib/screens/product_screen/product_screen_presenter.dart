import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/add_to_cart.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/getcart.dart';
import 'package:beinglearners/model/product.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/model/sub_category.dart';


abstract class ProductScreenContract {
  void onProdctSuccess(SubCategoryData response);
  void onProductError(String errorTxt);
  void onProdctDataSuccess(ProductData response);
  void onProductDataError(String errorTxt);
  void onAddToCartSuccess(AddToCart response);
  void onAddToCartError(String errorTxt);
  void onGetCartSuccess(GetCartData response);
  void onGetCartError(String errorTxt);
  void onDeleteCartSuccess(AddToCart response);
  void onDeleteCartError(String errorTxt);

}

class ProductScreenPresenter {

  ProductScreenContract _view;
  RestDataSource api = new RestDataSource();
  ProductScreenPresenter(this._view);

  getSubCategory(String cateId) {
    api.subCategory(cateId).then((SubCategoryData res) {
      _view.onProdctSuccess(res);
    }).catchError((Object error) => _view.onProductError(error.toString()));
  }

  getProduct(String cateId,String subCateId) {
    api.product(cateId,subCateId).then((ProductData res) {
      _view.onProdctDataSuccess(res);
    }).catchError((Object error) => _view.onProductDataError(error.toString()));
  }

  getAddToCart(String quantity,String productID,String token) {
    api.addToCart(quantity,productID,token).then((AddToCart res) {
      _view.onAddToCartSuccess(res);
    }).catchError((Object error) => _view.onAddToCartError(error.toString()));
  }

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