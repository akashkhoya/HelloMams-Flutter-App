// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderData _$SliderDataFromJson(Map<String, dynamic> json) {
  return SliderData(
      json['statusCode'] as int,
      (json['value'] as List)
          ?.map((e) =>
              e == null ? null : Value.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SliderDataToJson(SliderData instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'value': instance.sliderList
    };

Value _$ValueFromJson(Map<String, dynamic> json) {
  return Value(
      json['id'] as String,
      json['sliderName'] as String,
      json['sliderImg'] as String,
      json['isActive'] as bool,
      json['createdAt'] as String);
}

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'id': instance.id,
      'sliderName': instance.sliderName,
      'sliderImg': instance.sliderImg,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt
    };
