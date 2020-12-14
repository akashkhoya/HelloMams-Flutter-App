import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class CategoryData {

  CategoryData(this.statusCode,this.categoryList);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  List<ListData> categoryList = null;

  factory CategoryData.fromJson(Map<String, dynamic> json) => _$CategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}


@JsonSerializable()
class ListData {

  ListData(this.id,this.categoryTitle,this.categoryIMG,this.categoryName,this.categoryType,this.categoryCost,this.categoryDuration,this.isActive,this.createdAt);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'categoryTitle')
  final String categoryTitle;

  @JsonKey(name: 'categoryIMG')
  final String categoryIMG;

  @JsonKey(name: 'categoryName')
  final String categoryName;

  @JsonKey(name: 'categoryType')
  final String categoryType;

  @JsonKey(name: 'categoryCost')
  final String categoryCost;

  @JsonKey(name: 'categoryDuration')
  final String categoryDuration;

  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'createdAt')
  final String createdAt;


  factory ListData.fromJson(Map<String, dynamic> json) => _$ListDataFromJson(json);
  Map<String, dynamic> toJson() => _$ListDataToJson(this);
}