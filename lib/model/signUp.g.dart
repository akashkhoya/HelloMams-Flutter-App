// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpData _$SignUpDataFromJson(Map<String, dynamic> json) {
  return SignUpData(
      json['contentType'] as String,
      json['serializerSettings'] as String,
      json['statusCode'] as int,
      json['value'] as String);
}

Map<String, dynamic> _$SignUpDataToJson(SignUpData instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'serializerSettings': instance.serializerSettings,
      'statusCode': instance.statusCode,
      'value': instance.value
    };
