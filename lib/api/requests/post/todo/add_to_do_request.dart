import 'dart:convert';

import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import '../../../service/http_method.dart';

class AddToDoRequest extends CommonHttpRouter {
  final String title ;

  AddToDoRequest(this.title);

  @override
  String get path => ApiUrl.addToDo;

  @override
  HttpMethod get method => HttpMethod.POST;

  @override
  Object? body() => {'title': title};
}