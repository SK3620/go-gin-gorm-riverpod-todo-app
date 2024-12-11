import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../config/routes/routes_location.dart';
import '../config/routes/routes_provider.dart';
import '../widgets/custom_app_bar.dart';

class TodoListScreen extends ConsumerWidget {
  static TodoListScreen builder(BuildContext context,
      GoRouterState state,) =>
      const TodoListScreen();

  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "ToDoリスト",
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              navigationKey.currentState?.pop();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('ToDoリスト画面へ'),
              TextButton(
                  onPressed: () => context.push(AppRoute.createToDo.path),
                  child: const Text('ToDoタスク作成画面へ')
              )
            ],
          ),
        )
    );
  }
}