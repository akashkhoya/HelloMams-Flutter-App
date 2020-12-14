import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

@JsonSerializable()
class LoginData {

  LoginData(this.statusCode,this.value);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  final Value value;

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class Value {

  Value(this.statusCode,this.valueData);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  final ValueData valueData;


  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);
  Map<String, dynamic> toJson() => _$ValueToJson(this);
}


@JsonSerializable()
class ValueData {

  ValueData(this.access_token,this.user_name,this.fullName,this.accountNo,this.loginShield,this.message);


  @JsonKey(name: 'access_token')
  final String access_token;

  @JsonKey(name: 'user_name')
  final String user_name;

  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'AccountNo')
  final String accountNo;

  @JsonKey(name: 'LoginShield')
  final bool loginShield;

  @JsonKey(name: 'Message')
  final String message;

  factory ValueData.fromJson(Map<String, dynamic> json) => _$ValueDataFromJson(json);
  Map<String, dynamic> toJson() => _$ValueDataToJson(this);
}

