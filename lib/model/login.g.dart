// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) {
  return LoginData(
      json['statusCode'] as int,
      json['value'] == null
          ? null
          : Value.fromJson(json['value'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'value': instance.value
    };

Value _$ValueFromJson(Map<String, dynamic> json) {
  return Value(
      json['statusCode'] as int,
      json['value'] == null
          ? null
          : ValueData.fromJson(json['value'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'value': instance.valueData
    };

ValueData _$ValueDataFromJson(Map<String, dynamic> json) {
  return ValueData(
      json['access_token'] as String,
      json['user_name'] as String,
      json['fullName'] as String,
      json['AccountNo'] as String,
      json['LoginShield'] as bool,
      json['Message'] as String);
}

Map<String, dynamic> _$ValueDataToJson(ValueData instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'user_name': instance.user_name,
      'fullName': instance.fullName,
      'AccountNo': instance.accountNo,
      'LoginShield': instance.loginShield,
      'Message': instance.message
    };
