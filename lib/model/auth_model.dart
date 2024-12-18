import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthModel {
  final String? username;
  final String email;
  final String password;
  final String? jwtToken;

  AuthModel({
    this.username,
    required this.email,
    required this.password,
    this.jwtToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  static Map<String, dynamic> toJson(AuthModel instance) =>
      _$AuthModelToJson(instance);
}