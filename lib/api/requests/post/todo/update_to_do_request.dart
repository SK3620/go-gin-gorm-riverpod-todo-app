import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import 'package:spotify_app/model/to_do_model.dart';
import '../../../service/http_method.dart';

class UpdateToDoRequest extends CommonHttpRouter {
  final ToDoModel model;

  UpdateToDoRequest(this.model);

  @override
  String get path => ApiUrl.editToDo;

  @override
  HttpMethod get method => HttpMethod.PUT;

  @override
  Object? body() {
    ToDoModel.toJson(model);
  }
}