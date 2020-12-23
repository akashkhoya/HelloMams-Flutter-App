import 'dart:io';
import 'dart:ui';

import 'package:beinglearners/model/category.dart';
import 'package:beinglearners/model/comments/comment.dart';
import 'package:beinglearners/model/login.dart';

String URL_LINK = '';
bool status;
File select_image;
String SEARCH_TYPE_STATUS="Home";
CommentData COMMENT_RESPONSE;
String TITLE ="";
String SLUG ="";
bool category=false;
String TOKEN='';
