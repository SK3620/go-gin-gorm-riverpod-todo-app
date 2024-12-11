import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/widgets/custom_app_bar.dart';

class AuthScreen extends ConsumerWidget {
  static AuthScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const AuthScreen();
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(title: "認証画面"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('認証画面'),
            TextButton(
                onPressed: () => context.push(AppRoute.todoList.path),
                child: const Text('ToDoリスト画面へ')
            )
          ],
        ),
      )
    );
  }
}