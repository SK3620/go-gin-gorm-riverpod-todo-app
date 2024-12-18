import 'package:json_annotation/json_annotation.dart';

part 'to_do_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ToDoModel {
  final int id;
  String title;
  bool isCompleted;

  ToDoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) =>
      _$ToDoModelFromJson(json);

  static Map<String, dynamic> toJson(ToDoModel instance) =>
      _$ToDoModelToJson(instance);

  ToDoModel copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return ToDoModel(
      id: this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}