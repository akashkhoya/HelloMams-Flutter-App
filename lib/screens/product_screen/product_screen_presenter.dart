import 'package:beinglearners/api/data/rest_ds.dart';
import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/product.dart';
import 'package:beinglearners/model/slider.dart';
import 'package:beinglearners/model/sub_category.dart';


abstract class ProductScreenContract {
  void onProdctSuccess(SubCategoryData response);
  void onProductError(String errorTxt);
  void onProdctDataSuccess(ProductData response);
  void onProductDataError(String errorTxt);

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
  
}