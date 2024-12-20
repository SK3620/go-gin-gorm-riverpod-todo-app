import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotify_app/api/service/result.dart';
import 'package:spotify_app/model/custom_error.dart';
import 'package:spotify_app/model/custom_exception.dart';
import 'common_http_router.dart';
import 'http_method.dart';

/*
abstract class UseCase<I, O>
I → Input リクエストするデータの型を指定する CommonHttpRouter
O → Output レスポンスの型を指定する Map<String, dynamic>?
 */

class ApiService extends UseCase<CommonHttpRouter, Map<String, dynamic>?> {

  // UseCaseクラス内のFuture<O> execute(I request);の「O, I」に型を指定
  // excute()をoverrideをして具体的なAPIリクエスト処理を定義し、
  // リクエスト成功時 → Map<String, dynamic>?, 失敗時 → CustomExceptionまたはCustomErrorをthrowするようにする
  // ViewModel側でUseCaseをcall()し、Result型を返す
  @override
  Future<Map<String, dynamic>?> execute(CommonHttpRouter request) async {
    final dio = await request.dio;

    Response? response;
    try {
      if (request.method == HttpMethod.GET) {
        response = await dio.request(
          request.combinedPathAndQueryParameters
        );
      } else {
        response = await dio.request(
          request.combinedPathAndQueryParameters,
          data: request.body(),
        );
      }

      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);

      if (response == null) {
        throw CustomError(999, 'レスポンスがありません。');
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data['data'];
      } else {
      throw CustomError(response.statusCode ?? 999, response.statusMessage ?? '不明なエラーが発生しました。');
      }
    } on DioException catch (exception) {
      throw CustomException(exception.response?.statusCode ?? 999, exception.message ?? '不明なエラーが発生しました。');
    } on Exception catch (exception) {
      throw CustomException(999, exception.toString());
    }
  }
}

/*
abstract class UseCase<I, O>
I → Input リクエストするデータの型を指定する CommonHttpRouter
O → Output レスポンスの型を指定する Map<String, dynamic>?
 */

abstract class UseCase<I, O> {
  Future<Result<O>> call(I request) async {
    try {
      final data = await execute(request); // ここでAPIリクエストを実行
      return Result.success(data);
    } on CustomException catch (exception) {
      return Result.exception(exception);
    } on CustomError catch (error) {
      // エラーの場合はプログラムを終了させるためError用のResult型は定義していない
      debugPrint('statusCode: ${error.statsCode.toString()}');
      debugPrint('message: ${error.message}');
      throw error;
    }
  }

  Future<O> execute(I request);
}