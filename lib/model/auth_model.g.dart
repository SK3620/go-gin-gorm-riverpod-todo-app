// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String,
      password: json['password'] as String,
      jwtToken: json['jwtToken'] as String? ?? '',
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'jwtToken': instance.jwtToken,
    };
