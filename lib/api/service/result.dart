import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotify_app/api/service/api_service.dart';
import 'package:spotify_app/model/custom_exception.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T value) = Success<T>;
  const factory Result.exception(CustomException exception) = ResultException<T>;
}