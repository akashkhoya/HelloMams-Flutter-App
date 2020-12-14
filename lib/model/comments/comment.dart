import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
class CommentData {

  CommentData(this.blogCommentResponse);

  @JsonKey(name: 'BlogCommentResponse')
  final BlogCommentResponse blogCommentResponse;

  factory CommentData.fromJson(Map<String, dynamic> json) => _$CommentDataFromJson(json);
  Map<String, dynamic> toJson() => _$CommentDataToJson(this);
}

@JsonSerializable()
class BlogCommentResponse {

  BlogCommentResponse(this.message,this.status);

  @JsonKey(name: 'Status')
  final String status;

  @JsonKey(name: 'Message')
  final String message;



  factory BlogCommentResponse.fromJson(Map<String, dynamic> json) => _$BlogCommentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BlogCommentResponseToJson(this);
}