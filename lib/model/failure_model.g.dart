// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FailureModel _$FailureModelFromJson(Map<String, dynamic> json) => FailureModel(
      statsCode: (json['statsCode'] as num?)?.toInt() ?? 999,
      message: json['message'] as String? ?? 'エラーが発生しました。',
      detail: json['detail'] as String? ?? '詳細なエラー内容がありません。原因の調査が必要です。',
    );

Map<String, dynamic> _$FailureModelToJson(FailureModel instance) =>
    <String, dynamic>{
      'statsCode': instance.statsCode,
      'message': instance.message,
      'detail': instance.detail,
    };
