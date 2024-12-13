import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/failure_model.dart';
import 'package:spotify_app/providers/auth_view_model.dart';
import 'package:spotify_app/widgets/auth_button.dart';
import 'package:spotify_app/widgets/auth_text_field.dart';
import 'package:spotify_app/widgets/common_progress.dart';
import 'package:spotify_app/widgets/common_app_bar.dart';
import 'package:spotify_app/widgets/common_error_dialog.dart';

class AuthScreen extends ConsumerWidget {


  static AuthScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const AuthScreen();

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final vm = ref.watch(authViewModelProvider);

    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: const CommonAppBar(title: "認証画面"),
      body: vm.when(
        loading: () => const CommonProgress(),
        error: (error, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CommonErrorDialog.show(error: error as FailureModel);
            });
        },
        data: (_) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                AuthTextField(
                  hintText: "ユーザー名（サインインの場合は不要）",
                  icon: Icons.person,
                  controller: usernameController,
                ),
                AuthTextField(
                  hintText: "メールアドレス",
                  icon: Icons.email,
                  controller: emailController,
                ),
                AuthTextField(
                  hintText: "パスワード",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 40),
                AuthButton(
                  label: "サインアップ",
                  onPressed: () {
                    context.push(AppRoute.todoList.path);
                  },
                ),
                const SizedBox(height: 16),
                AuthButton(
                  label: "サインイン",
                  onPressed: () {
                    context.push(AppRoute.todoList.path);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

