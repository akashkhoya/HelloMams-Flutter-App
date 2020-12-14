import 'package:json_annotation/json_annotation.dart';
import 'login.dart';
part 'signUp.g.dart';

@JsonSerializable()
class SignUpData {

  SignUpData(this.contentType,this.serializerSettings,this.statusCode,this.value);

  @JsonKey(name: 'contentType')
  final String contentType;

  @JsonKey(name: 'serializerSettings')
  final String serializerSettings;

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  final String value;


  factory SignUpData.fromJson(Map<String, dynamic> json) => _$SignUpDataFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpDataToJson(this);
}


