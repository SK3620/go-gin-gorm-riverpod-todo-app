import 'package:dio/dio.dart';
import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/config/config.dart';
import 'package:spotify_app/config/storage.dart';
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

  List<String>? get pathParameters => null;

  Map<String, dynamic>? get queryParameters => null;

  Object? body() => null;

  // パスパラメーターとクエリパラメーターを組み合わせる
  String get combinedPathAndQueryParameters {
    String combinedPath = path;
    if (pathParameters != null) {
      combinedPath += '/${pathParameters!.join('/')}';
    }
    if (queryParameters != null) {
      combinedPath += '?${queryParameters!.entries
          .map((entry) => '${entry.key}=${entry.value}')
          .join('&')}';
    }
    return combinedPath;
  }

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