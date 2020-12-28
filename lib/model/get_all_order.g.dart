// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllOrderData _$AllOrderDataFromJson(Map<String, dynamic> json) {
  return AllOrderData(
      json['statusCode'] as int,
      (json['value'] as List)
          ?.map((e) => e == null
              ? null
              : AllOrderDataList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AllOrderDataToJson(AllOrderData instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'value': instance.allOrderDataList
    };

AllOrderDataList _$AllOrderDataListFromJson(Map<String, dynamic> json) {
  return AllOrderDataList(
      json['id'] as String,
      json['userID'] as String,
      json['cartIDs'] as String,
      json['paymentGatewayID'] as String,
      json['paymentMethod'] as String,
      json['transactionID'] as String,
      (json['totalAmount'] as num)?.toDouble(),
      json['address'] as String,
      json['orderStatus'] as String,
      json['paymentStatus'] as String,
      json['isCoupounApplied'] as bool,
      json['createdAt'] as String,
      (json['cartOrders'] as List)
          ?.map((e) => e == null
              ? null
              : CartOrdersList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AllOrderDataListToJson(AllOrderDataList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'cartIDs': instance.cartIDs,
      'paymentGatewayID': instance.paymentGatewayID,
      'paymentMethod': instance.paymentMethod,
      'transactionID': instance.transactionID,
      'totalAmount': instance.totalAmount,
      'address': instance.address,
      'orderStatus': instance.orderStatus,
      'paymentStatus': instance.paymentStatus,
      'isCoupounApplied': instance.isCoupounApplied,
      'createdAt': instance.createdAt,
      'cartOrders': instance.cartOrdersList
    };

CartOrdersList _$CartOrdersListFromJson(Map<String, dynamic> json) {
  return CartOrdersList(
      json['id'] as String,
      json['productID'] as String,
      json['ipAddress'] as String,
      json['userID'] as String,
      json['productTitle'] as String,
      json['productImage'] as String,
      json['productQuantity'] as String,
      (json['totalAmount'] as num)?.toDouble(),
      (json['servicePrice'] as num)?.toDouble(),
      json['createdAt'] as String);
}

Map<String, dynamic> _$CartOrdersListToJson(CartOrdersList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productID': instance.productID,
      'ipAddress': instance.ipAddress,
      'userID': instance.userID,
      'productTitle': instance.productTitle,
      'productImage': instance.productImage,
      'productQuantity': instance.productQuantity,
      'totalAmount': instance.totalAmount,
      'servicePrice': instance.servicePrice,
      'createdAt': instance.createdAt
    };
