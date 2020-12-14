import 'package:json_annotation/json_annotation.dart';
import 'category.dart';
part 'slider.g.dart';

@JsonSerializable()
class SliderData {

  SliderData(this.statusCode,this.sliderList);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  List<Value> sliderList = null;

  factory SliderData.fromJson(Map<String, dynamic> json) => _$SliderDataFromJson(json);
  Map<String, dynamic> toJson() => _$SliderDataToJson(this);
}

@JsonSerializable()
class Value {

  Value(this.id,this.sliderName,this.sliderImg,this.isActive,this.createdAt);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'sliderName')
  final String sliderName;

  @JsonKey(name: 'sliderImg')
  final String sliderImg;

  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'createdAt')
  final String createdAt;


  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);
  Map<String, dynamic> toJson() => _$ValueToJson(this);
}




