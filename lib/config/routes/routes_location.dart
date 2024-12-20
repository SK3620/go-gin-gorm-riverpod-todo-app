enum AppRoute {
  auth, // 認証画面
  todoList // Todoリスト画面
}

// それぞれの画面のパスを定義
extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.auth:
        return "/auth";
      case AppRoute.todoList:
        return "/todoList";
      default:
        return "";
    }
  }
}