// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductData _$ProductDataFromJson(Map<String, dynamic> json) {
  return ProductData(
      json['statusCode'] as int,
      (json['value'] as List)
          ?.map((e) => e == null
              ? null
              : ProductDataList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'value': instance.productList
    };

ProductDataList _$ProductDataListFromJson(Map<String, dynamic> json) {
  return ProductDataList(
      json['id'] as String,
      json['categoryID'] as String,
      json['subCategoryID'] as String,
      json['productTitle'] as String,
      json['productStandard'] as String,
      json['productPrice'] as String,
      json['productStandardPrice'] as String,
      json['productPremiumPrice'] as String,
      json['productPricePerMinuteStandard'] as String,
      json['productPricePerMinutePremium'] as String,
      json['discountPrice'] as String,
      json['discountPercentOrFIX'] as String,
      json['discountPercentOrFIXValue'] as String,
      json['productDuration'] as String,
      (json['productDescriptions'] as List)
          ?.map((e) => e == null
              ? null
              : ProductDescriptions.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['productKeywords'] as String,
      json['productImg'] as String,
      json['stock'] as String,
      json['priceToUS'] as String,
      json['minimumServiceTime'] as String,
      json['isTrending'] as bool,
      json['isActive'] as bool,
      json['createdAt'] as String);
}

Map<String, dynamic> _$ProductDataListToJson(ProductDataList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryID': instance.categoryID,
      'subCategoryID': instance.subCategoryID,
      'productTitle': instance.productTitle,
      'productStandard': instance.productStandard,
      'productPrice': instance.productPrice,
      'productStandardPrice': instance.productStandardPrice,
      'productPremiumPrice': instance.productPremiumPrice,
      'productPricePerMinuteStandard': instance.productPricePerMinuteStandard,
      'productPricePerMinutePremium': instance.productPricePerMinutePremium,
      'discountPrice': instance.discountPrice,
      'discountPercentOrFIX': instance.discountPercentOrFIX,
      'discountPercentOrFIXValue': instance.discountPercentOrFIXValue,
      'productDuration': instance.productDuration,
      'productDescriptions': instance.productDescriptionsList,
      'productKeywords': instance.productKeywords,
      'productImg': instance.productImg,
      'stock': instance.stock,
      'priceToUS': instance.priceToUS,
      'minimumServiceTime': instance.minimumServiceTime,
      'isTrending': instance.isTrending,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt
    };

ProductDescriptions _$ProductDescriptionsFromJson(Map<String, dynamic> json) {
  return ProductDescriptions(json['id'] as String, json['productId'] as String,
      json['descriptionHeading'] as String, json['descriptions'] as String);
}

Map<String, dynamic> _$ProductDescriptionsToJson(
        ProductDescriptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'descriptionHeading': instance.descriptionHeading,
      'descriptions': instance.descriptions
    };
