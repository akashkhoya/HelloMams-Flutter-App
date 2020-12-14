import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class ProductData {

  ProductData(this.statusCode,this.productList);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  List<ProductDataList> productList = null;

  factory ProductData.fromJson(Map<String, dynamic> json) => _$ProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}


@JsonSerializable()
class ProductDataList {

  ProductDataList(this.id,this.categoryID,this.subCategoryID,this.productTitle,this.productStandard,this.productPrice,
      this.productStandardPrice,this.productPremiumPrice,this.productPricePerMinuteStandard,this.productPricePerMinutePremium,this.discountPrice,
      this.discountPercentOrFIX,this.discountPercentOrFIXValue,this.productDuration,this.productDescriptionsList,this.productKeywords,this.productImg,
      this.stock,this.priceToUS,this.minimumServiceTime,this.isTrending,this.isActive,this.createdAt);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'categoryID')
  final String categoryID;

  @JsonKey(name: 'subCategoryID')
  final String subCategoryID;

  @JsonKey(name: 'productTitle')
  final String productTitle;

  @JsonKey(name: 'productStandard')
  final String productStandard;

  @JsonKey(name: 'productPrice')
  final String productPrice;

  @JsonKey(name: 'productStandardPrice')
  final String productStandardPrice;

  @JsonKey(name: 'productPremiumPrice')
  final String productPremiumPrice;

  @JsonKey(name: 'productPricePerMinuteStandard')
  final String productPricePerMinuteStandard;

  @JsonKey(name: 'productPricePerMinutePremium')
  final String productPricePerMinutePremium;

  @JsonKey(name: 'discountPrice')
  final String discountPrice;

  @JsonKey(name: 'discountPercentOrFIX')
  final String discountPercentOrFIX;

  @JsonKey(name: 'discountPercentOrFIXValue')
  final String discountPercentOrFIXValue;

  @JsonKey(name: 'productDuration')
  final String productDuration;

  @JsonKey(name: 'productDescriptions')
  List<ProductDescriptions> productDescriptionsList = null;

  @JsonKey(name: 'productKeywords')
  final String productKeywords;

  @JsonKey(name: 'productImg')
  final String productImg;

  @JsonKey(name: 'stock')
  final String stock;

  @JsonKey(name: 'priceToUS')
  final String priceToUS;

  @JsonKey(name: 'minimumServiceTime')
  final String minimumServiceTime;

  @JsonKey(name: 'isTrending')
  final bool isTrending;

  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'createdAt')
  final String createdAt;


  factory ProductDataList.fromJson(Map<String, dynamic> json) => _$ProductDataListFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataListToJson(this);
}

@JsonSerializable()
class ProductDescriptions {

  ProductDescriptions(this.id,this.productId,this.descriptionHeading,this.descriptions);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'productId')
  final String productId;

  @JsonKey(name: 'descriptionHeading')
  final String descriptionHeading;

  @JsonKey(name: 'descriptions')
  final String descriptions;

  factory ProductDescriptions.fromJson(Map<String, dynamic> json) => _$ProductDescriptionsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDescriptionsToJson(this);
}