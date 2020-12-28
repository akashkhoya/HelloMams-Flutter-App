import 'package:json_annotation/json_annotation.dart';
part 'get_all_order.g.dart';

@JsonSerializable()
class AllOrderData {

  AllOrderData(this.statusCode,this.allOrderDataList);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  List<AllOrderDataList> allOrderDataList = null;

  factory AllOrderData.fromJson(Map<String, dynamic> json) => _$AllOrderDataFromJson(json);
  Map<String, dynamic> toJson() => _$AllOrderDataToJson(this);
}


@JsonSerializable()
class AllOrderDataList {

  AllOrderDataList(this.id,this.userID,this.cartIDs,this.paymentGatewayID,this.paymentMethod,this.transactionID,this.totalAmount,this.address,this.orderStatus,
      this.paymentStatus,this.isCoupounApplied,this.createdAt,this.cartOrdersList);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'userID')
  final String userID;

  @JsonKey(name: 'cartIDs')
  final String cartIDs;

  @JsonKey(name: 'paymentGatewayID')
  final String paymentGatewayID;

  @JsonKey(name: 'paymentMethod')
  final String paymentMethod;

  @JsonKey(name: 'transactionID')
  final String transactionID;

  @JsonKey(name: 'totalAmount')
  final double totalAmount;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'orderStatus')
  final String orderStatus;

  @JsonKey(name: 'paymentStatus')
  final String paymentStatus;

  @JsonKey(name: 'isCoupounApplied')
  final bool isCoupounApplied;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'cartOrders')
  List<CartOrdersList> cartOrdersList = null;


  factory AllOrderDataList.fromJson(Map<String, dynamic> json) => _$AllOrderDataListFromJson(json);
  Map<String, dynamic> toJson() => _$AllOrderDataListToJson(this);
}

@JsonSerializable()
class CartOrdersList {

  CartOrdersList(this.id,this.productID,this.ipAddress,this.userID,this.productTitle,this.productImage,this.productQuantity,this.totalAmount,this.servicePrice,
      this.createdAt);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'productID')
  final String productID;

  @JsonKey(name: 'ipAddress')
  final String ipAddress;

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

  @JsonKey(name: 'createdAt')
  final String createdAt;

  factory CartOrdersList.fromJson(Map<String, dynamic> json) => _$CartOrdersListFromJson(json);
  Map<String, dynamic> toJson() => _$CartOrdersListToJson(this);
}