import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import 'package:spotify_app/model/to_do_model.dart';
import '../../../service/http_method.dart';

class FetchToDosRequest extends CommonHttpRouter {

  @override
  String get path => ApiUrl.fetchToDos;

  @override
  HttpMethod get method => HttpMethod.GET;
}