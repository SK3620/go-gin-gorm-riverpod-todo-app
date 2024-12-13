import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import '../../../service/http_method.dart';

class ToggleCompletionRequest extends CommonHttpRouter {
  final int toDoId;

  ToggleCompletionRequest(this.toDoId);

  @override
  String get path => ApiUrl.toggleCompletion;

  @override
  HttpMethod get method => HttpMethod.PUT;

  @override
  Map<String, dynamic>? get queryParameters => {'toDoId': toDoId};
}