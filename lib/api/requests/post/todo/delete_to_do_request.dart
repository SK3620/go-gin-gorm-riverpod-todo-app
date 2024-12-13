import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import 'package:spotify_app/model/to_do_model.dart';
import '../../../service/http_method.dart';

class DeleteToDoRequest extends CommonHttpRouter {
  final int toDoId;

  DeleteToDoRequest(this.toDoId);

  @override
  String get path => ApiUrl.deleteToDo;

  @override
  HttpMethod get method => HttpMethod.DELETE;

  @override
  Map<String, dynamic>? get queryParameters => {'id': toDoId};
}