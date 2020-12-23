// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getcart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartData _$GetCartDataFromJson(Map<String, dynamic> json) {
  return GetCartData(
      json['statusCode'] as int,
      (json['value'] as List)
          ?.map((e) => e == null
              ? null
              : GetCartList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GetCartDataToJson(GetCartData instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'value': instance.getCartList
    };

GetCartList _$GetCartListFromJson(Map<String, dynamic> json) {
  return GetCartList(
      json['id'] as String,
      json['productID'] as String,
      json['userID'] as String,
      json['productTitle'] as String,
      json['productImage'] as String,
      json['productQuantity'] as String,
      (json['totalAmount'] as num)?.toDouble(),
      (json['servicePrice'] as num)?.toDouble());
}

Map<String, dynamic> _$GetCartListToJson(GetCartList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productID': instance.productID,
      'userID': instance.userID,
      'productTitle': instance.productTitle,
      'productImage': instance.productImage,
      'productQuantity': instance.productQuantity,
      'totalAmount': instance.totalAmount,
      'servicePrice': instance.servicePrice
    };
