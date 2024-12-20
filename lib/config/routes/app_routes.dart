import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes_location.dart';
import 'package:spotify_app/config/routes/routes_provider.dart';
import '../../screens/auth_screen.dart';
import '../../screens/todo_list_screen.dart';

// アプリ内のルート設定を定義
// builder: に対応する画面ウィジェットを返す
final appRoutes = [
  // 認証画面
  GoRoute(
    path: AppRoute.auth.path,
    parentNavigatorKey: navigationKey,
    builder: AuthScreen.builder,
  ),
  // Todoリスト画面
  GoRoute(
    path: AppRoute.todoList.path,
    parentNavigatorKey: navigationKey,
    builder: TodoListScreen.builder,
  ),
];