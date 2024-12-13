import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/widgets/common_app_bar.dart';

import '../config/routes/routes_provider.dart';

class CreateToDoScreen extends ConsumerWidget {
  static CreateToDoScreen builder(BuildContext context,
      GoRouterState state,) =>
      const CreateToDoScreen();

  const CreateToDoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: CommonAppBar(
          title: "ToDoタスク作成",
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
              const Text('ToDoタスク作成画面へ'),
              TextButton(
                  onPressed: () => context.pop,
                  child: const Text('ToDoリスト画面へ')
              )
            ],
          ),
        )
    );
  }
}