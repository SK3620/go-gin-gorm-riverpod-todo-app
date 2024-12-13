import 'package:json_annotation/json_annotation.dart';

part 'failure_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FailureModel extends Error {
  final int statsCode;
  final String message;
  final String detail;

  FailureModel({
    this.statsCode = 999,
    this.message = 'エラーが発生しました。',
    this.detail = '詳細なエラー内容がありません。原因の調査が必要です。'
  });

  factory FailureModel.fromJson(Map<String, dynamic> json) =>
      _$FailureModelFromJson(json);

  static Map<String, dynamic> toJson(FailureModel instance) =>
      _$FailureModelToJson(instance);
}