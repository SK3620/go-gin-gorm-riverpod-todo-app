enum AppRoute {
  auth,
  todoList,
  createToDo
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.auth:
        return "/auth";
      case AppRoute.todoList:
        return "/todoList";
      case AppRoute.createToDo:
        return "/createTodo";

      default:
        return "/auth";
    }
  }
}