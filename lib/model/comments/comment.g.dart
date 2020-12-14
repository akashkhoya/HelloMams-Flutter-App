// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentData _$CommentDataFromJson(Map<String, dynamic> json) {
  return CommentData(json['BlogCommentResponse'] == null
      ? null
      : BlogCommentResponse.fromJson(
          json['BlogCommentResponse'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CommentDataToJson(CommentData instance) =>
    <String, dynamic>{'BlogCommentResponse': instance.blogCommentResponse};

BlogCommentResponse _$BlogCommentResponseFromJson(Map<String, dynamic> json) {
  return BlogCommentResponse(
      json['Message'] as String, json['Status'] as String);
}

Map<String, dynamic> _$BlogCommentResponseToJson(
        BlogCommentResponse instance) =>
    <String, dynamic>{'Status': instance.status, 'Message': instance.message};
