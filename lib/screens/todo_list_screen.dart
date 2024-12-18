import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/to_do_model.dart';
import 'package:spotify_app/providers/to_do_view_model.dart';
import 'package:spotify_app/widgets/common_app_bar.dart';
import 'package:spotify_app/widgets/to_do_dialog.dart';
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
      appBar: CommonAppBar(
        title: "Todoリスト",
        actions: [
          TextButton(
              onPressed: () => { vmNotifier.fetchToDos() },
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
          showAddDialog(vmNotifier);
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
                  showEditDialog(vmNotifier, todo);
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
  }

  Widget _buildLoadingOrErrorDialog(AsyncValue<List<ToDoModel>> vm) {
    return vm.when(
      loading: () => const Center(
        child: CircularProgressIndicator(strokeWidth: 6.0, color: Colors.grey,),
      ),
      error: (error, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CommonErrorDialog.show(error: error as FailureModel);
        });
        return Container();
      },
      data: (_) => Container(),
    );
  }
}
