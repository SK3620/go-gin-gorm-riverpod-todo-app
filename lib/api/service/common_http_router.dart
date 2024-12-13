import 'package:dio/dio.dart';
import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/widgets/config.dart';
import 'package:spotify_app/widgets/storage.dart';
import 'http_method.dart';

abstract class CommonHttpRouter {

  String baseUrl = ApiUrl.baseUrl;

  String get path;

  HttpMethod get method;

  Future<Map<String, String>> get headers async =>
      {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ await SecureStorage().load(
            Config.secureStorageJwtTokenKey)}',
      };

  Map<String, dynamic>? get queryParameters => null;

  Object? body() => null;

  Future<Dio> get dio async {
    final headers = await this.headers;
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        method: method.name,
        responseType: ResponseType.json,
        connectTimeout: Config.apiDuration,
      ),
    );
  }
}