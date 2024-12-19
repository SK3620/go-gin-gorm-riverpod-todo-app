import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotify_app/api/service/result.dart';
import 'package:spotify_app/model/custom_error.dart';
import 'package:spotify_app/model/custom_exception.dart';
import 'common_http_router.dart';
import 'http_method.dart';

class ApiService extends UseCase<CommonHttpRouter, Map<String, dynamic>?> {
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

abstract class UseCase<I, O> {
  Future<Result<O>> call(I request) async {
    try {
      final data = await execute(request);
      return Result.success(data);
    } on CustomException catch (exception) {
      return Result.exception(exception);
    } on CustomError catch (error) {
      debugPrint('statusCode: ${error.statsCode.toString()}');
      debugPrint('message: ${error.message}');
      throw error;
    }
  }

  Future<O> execute(I request);
}