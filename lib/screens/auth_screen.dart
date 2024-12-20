import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes.dart';
import 'package:spotify_app/model/custom_exception.dart';
import 'package:spotify_app/providers/auth_view_model.dart';
import 'package:spotify_app/widgets/auth_button.dart';
import 'package:spotify_app/widgets/auth_text_field.dart';
import 'package:spotify_app/widgets/common_app_bar.dart';
import 'package:spotify_app/widgets/common_error_dialog.dart';

class AuthScreen extends ConsumerWidget {
  static AuthScreen builder(BuildContext context,
      GoRouterState state,) =>
      const AuthScreen();

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  認証状態(true or false)、ローディング中状態、エラー状態を監視
    final vm = ref.watch(authViewModelProvider);
    // AuthViewModelのインスタンス
    final vmNotifier = ref.read(authViewModelProvider.notifier);

    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: const CommonAppBar(title: "認証"),
      body: Stack(
        children: [
          _authForm(
            usernameController,
            emailController,
            passwordController,
            vmNotifier,
          ),
          _buildLoadingOrErrorDialog(vm),
        ],
      ),
    );
  }

  // 認証フォーム
  Widget _authForm(
      TextEditingController usernameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      AuthViewModel vmNotifier
      ) {
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
              // サインアップ処理発火
              vmNotifier.signUp(
                usernameController.text,
                emailController.text,
                passwordController.text,
              );
            },
          ),
          const SizedBox(height: 16),
          AuthButton(
            label: "サインイン",
            onPressed: () {
              // サインイン処理発火
              vmNotifier.signIn(
                emailController.text,
                passwordController.text,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOrErrorDialog(AsyncValue<bool> vm) {
    return vm.when(
      // 状態(state)がローディング中の場合
    loading: () =>
      const Center(
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
      // 状態(state)がtrue(認証成功）の場合
      data: (didAuthenticate) {
        if (didAuthenticate) {
          // レンダリング完了後にToDoリスト画面へ遷移
          WidgetsBinding.instance.addPostFrameCallback((_) {
            navigationKey.currentContext?.push(AppRoute.todoList.path);
          });
        }
        return Container();
      },
    );
  }
}

