import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/to_do_model.dart';
import 'package:spotify_app/providers/to_do_view_model.dart';
import '../model/failure_model.dart';
import '../widgets/common_error_dialog.dart';

class TodoListScreen extends ConsumerWidget {
  static TodoListScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const TodoListScreen();

  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(toDoViewModelProvider);
    final vmNotifier = ref.read(toDoViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('ToDoリスト')),
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()), // ローディング中
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CommonErrorDialog.show(error: error as FailureModel); // エラーダイアログ表示
          });
          return const Center(child: Text('エラーが発生しました'));
        },
        data: (todos) {
          // ToDoリストのデータがある場合の表示
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    todo.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                    color: todo.isCompleted ? Colors.green : null,
                  ),
                  onPressed: () {
                    vmNotifier.toggleCompletion(todo.id);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(vmNotifier, todo);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        vmNotifier.removeTodo(todo.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(vmNotifier);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(ToDoViewModel vmNotifier) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: navigationKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text('ToDoを追加'),
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

  void _showEditDialog(ToDoViewModel vmNotifier, ToDoModel todo) {
    final TextEditingController controller = TextEditingController(text: todo.title);

    showDialog(
      context: navigationKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text('ToDoを編集'),
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
                vmNotifier.updateTodo(
                  todo.id,
                  controller.text,
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
}
