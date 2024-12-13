import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:spotify_app/api/service/result.dart';
import 'package:spotify_app/model/failure_model.dart';
import 'common_http_router.dart';
import 'http_method.dart';

class ApiService extends UseCase<CommonHttpRouter, Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> execute(CommonHttpRouter request) async {
    final dio = await request.dio;

    Response? response;
    try {
      if (request.method == HttpMethod.GET) {
        response = await dio.request(
          request.path,
          queryParameters: request.queryParameters,
        );
      } else {
        response = await dio.request(
          request.path,
          data: request.body(),
        );
      }

      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);

      if (response == null) {
        throw FailureModel(detail: 'レスポンスがありません。');
      }

      // 今回はエラーも例外も統一してエラーダイアログとして表示するため、FailureModelにまとめてマッピングし、エラーとして扱う
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.extra;
      } else {
        final httpError = FailureModel.fromJson(response.extra);
        throw httpError;
      }
    } on DioException catch (exception) {
      print(exception);
      throw FailureModel(detail: exception.message ?? '');
    } on Exception catch (exception) {
      print(exception);
      throw FailureModel(detail: exception.toString());
    }
  }
}

abstract class UseCase<I, O> {
  Future<Result<O>> call(I request) async {
    try {
      final data = await execute(request);
      return Result.success(data);
    } on FailureModel catch (error) {
      return Result.error(error);
    }
  }

  Future<O> execute(I request);
}