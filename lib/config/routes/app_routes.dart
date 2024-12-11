import 'package:go_router/go_router.dart';
import 'package:spotify_app/config/routes/routes_location.dart';
import 'package:spotify_app/config/routes/routes_provider.dart';
import '../../screens/auth_screen.dart';
import '../../screens/create_to_do_screen.dart';
import '../../screens/todo_list_screen.dart';

final appRoutes = [
  GoRoute(
    path: AppRoute.auth.path,
    parentNavigatorKey: navigationKey,
    builder: AuthScreen.builder,
  ),
  GoRoute(
    path: AppRoute.todoList.path,
    parentNavigatorKey: navigationKey,
    builder: TodoListScreen.builder,
  ),
  GoRoute(
    path: AppRoute.createToDo.path,
    parentNavigatorKey: navigationKey,
    builder: CreateToDoScreen.builder,
  ),
];