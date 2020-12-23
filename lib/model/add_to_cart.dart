import 'package:json_annotation/json_annotation.dart';
part 'add_to_cart.g.dart';

@JsonSerializable()
class AddToCart {

  AddToCart(this.statusCode,this.value);

  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'value')
  final String value;

  factory AddToCart.fromJson(Map<String, dynamic> json) => _$AddToCartFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartToJson(this);
}
