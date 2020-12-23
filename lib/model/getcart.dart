import 'package:json_annotation/json_annotation.dart';
part 'getcart.g.dart';

@JsonSerializable()
class GetCartData {

  GetCartData(this.statusCode,this.getCartList);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  List<GetCartList> getCartList = null;

  factory GetCartData.fromJson(Map<String, dynamic> json) => _$GetCartDataFromJson(json);
  Map<String, dynamic> toJson() => _$GetCartDataToJson(this);
}


@JsonSerializable()
class GetCartList {

  GetCartList(this.id,this.productID,this.userID,this.productTitle,this.productImage,this.productQuantity,
      this.totalAmount,this.servicePrice);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'productID')
  final String productID;

  @JsonKey(name: 'userID')
  final String userID;

  @JsonKey(name: 'productTitle')
  final String productTitle;

  @JsonKey(name: 'productImage')
  final String productImage;

  @JsonKey(name: 'productQuantity')
  final String productQuantity;

  @JsonKey(name: 'totalAmount')
  final double totalAmount;

  @JsonKey(name: 'servicePrice')
  final double servicePrice;

  factory GetCartList.fromJson(Map<String, dynamic> json) => _$GetCartListFromJson(json);
  Map<String, dynamic> toJson() => _$GetCartListToJson(this);
}
