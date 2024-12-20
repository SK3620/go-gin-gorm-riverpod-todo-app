import 'package:dio/dio.dart';
import 'package:spotify_app/api/service/api_url.dart';
import 'package:spotify_app/config/config.dart';
import 'package:spotify_app/config/storage.dart';
import 'http_method.dart';

// APIリクエストの共通部分を定義する抽象クラス
// 各APIリクエストの詳細なパスやパラメータ、ボディなどはサブクラスで実装
abstract class CommonHttpRouter {

  // 基本URL
  String baseUrl = ApiUrl.baseUrl;

  // 各APIエンドポイントのパス
  String get path;

  // GET、POST、PUT、DELETE
  HttpMethod get method;

  // ヘッダー
  Future<Map<String, String>> get headers async =>
      {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ await SecureStorage().load(
            Config.secureStorageJwtTokenKey)}', // 端末のローカルに保存したJWT認証トークンをヘッダーに追加
      };

  // パスパラメーター
  List<String>? get pathParameters => null;

  // クエリパラメーター
  Map<String, dynamic>? get queryParameters => null;

  // ボディ
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

  // HTTP通信をするためのDioインスタンスを生成
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