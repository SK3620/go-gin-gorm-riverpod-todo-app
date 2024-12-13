import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotify_app/model/failure_model.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T value) = Success<T>;
  const factory Result.error(FailureModel error) = ResultError<T>;
}