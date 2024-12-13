import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import 'package:spotify_app/model/auth_model.dart';
import '../../../service/http_method.dart';

class SignInRequest extends CommonHttpRouter {
  final AuthModel model;

  SignInRequest(this.model);

  @override
  String get path => ApiUrl.signIn;

  @override
  HttpMethod get method => HttpMethod.POST;

  @override
  Object? body() {
    AuthModel.toJson(model);
  }
}