import 'package:json_annotation/json_annotation.dart';
part 'sub_category.g.dart';

@JsonSerializable()
class SubCategoryData {

  SubCategoryData(this.statusCode,this.sub_categoryList);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  List<SubCateData> sub_categoryList = null;

  factory SubCategoryData.fromJson(Map<String, dynamic> json) => _$SubCategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryDataToJson(this);
}


@JsonSerializable()
class SubCateData {

  SubCateData(this.id,this.categoryID,this.subCategoryIMG,this.subCategoryName,this.isActive,this.createdAt);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'categoryID')
  final String categoryID;

  @JsonKey(name: 'subCategoryIMG')
  final String subCategoryIMG;

  @JsonKey(name: 'subCategoryName')
  final String subCategoryName;

  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'createdAt')
  final String createdAt;


  factory SubCateData.fromJson(Map<String, dynamic> json) => _$SubCateDataFromJson(json);
  Map<String, dynamic> toJson() => _$SubCateDataToJson(this);
}