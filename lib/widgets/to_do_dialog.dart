import 'package:flutter/material.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/to_do_model.dart';
import 'package:spotify_app/providers/to_do_view_model.dart';

void showAddDialog(ToDoViewModel vmNotifier) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: navigationKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text('追加'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'タイトル'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              // ToDo新規作成処理を発火
              vmNotifier.addTodo(controller.text);
              Navigator.of(context).pop();
            },
            child: Text('追加'),
          ),
        ],
      );
    },
  );
}

void showEditDialog(ToDoViewModel vmNotifier, ToDoModel todo) {
  final TextEditingController controller = TextEditingController(text: todo.title);
  bool isCompleted = todo.isCompleted;

  showDialog(
    context: navigationKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text('編集'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'タイトル'),
                ),
                Row(
                  children: [
                    Text('完了:'),
                    Switch(
                      value: isCompleted,
                      onChanged: (value) {
                        setState(() {
                          isCompleted = value;  // トグルボタンの状態変更をUIに反映
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              // ToDo更新処理を発火
              vmNotifier.updateTodo(
                todo.id,
                controller.text,
                isCompleted,  // 完了状態を渡す
              );
              Navigator.of(context).pop();
            },
            child: Text('更新'),
          ),
        ],
      );
    },
  );
}

