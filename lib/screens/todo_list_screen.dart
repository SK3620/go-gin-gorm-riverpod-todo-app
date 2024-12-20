import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/to_do_model.dart';
import 'package:spotify_app/providers/to_do_view_model.dart';
import 'package:spotify_app/widgets/common_app_bar.dart';
import 'package:spotify_app/widgets/to_do_dialog.dart';
import '../model/custom_exception.dart';
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
    //  List<ToDoModel>の値、ローディング中状態、エラー状態を監視
    final vm = ref.watch(toDoViewModelProvider);
    // ToDoViewModelのインスタンス
    final vmNotifier = ref.read(toDoViewModelProvider.notifier);

    return Scaffold(
      appBar: CommonAppBar(
        title: "Todoリスト",
        actions: [
          TextButton(
              onPressed: () => { vmNotifier.fetchToDos() }, // ToDo全件取得処理を発火
              child: const Center(child: Text('再取得', style: TextStyle(fontSize: 16, color: Colors.purple),),)
          )
        ],
      ),
      body: Stack(
        children: [
          _todoList(
              vm.value ?? [],
              vmNotifier
          ),
          _buildLoadingOrErrorDialog(vm),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo新規作成ダイアログを表示
          showAddDialog(vmNotifier); // ToDoViewModelを渡す
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _todoList(
      List<ToDoModel> todos,
      ToDoViewModel vmNotifier
      ) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          leading: Icon(
            Icons.check,
            size: 32,
            color: todo.isCompleted ? Colors.green : Colors.black26,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Todo編集ダイアログを表示
                  showEditDialog(vmNotifier, todo);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Todo削除処理を発火
                  vmNotifier.removeTodo(todo.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingOrErrorDialog(AsyncValue<List<ToDoModel>> vm) {
    return vm.when(
      // 状態(state)がローディング中の場合
      loading: () => const Center(
        child: CircularProgressIndicator(strokeWidth: 6.0, color: Colors.grey,),
      ),
      // 状態(state)がエラーの場合
      error: (error, _) {
        // レンダリング完了後にエラーダイアログを表示
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CommonErrorDialog.show(exception: error as CustomException);
        });
        return Container();
      },
      // 空のWidgetを返す
      data: (_) => Container(),
    );
  }
}
