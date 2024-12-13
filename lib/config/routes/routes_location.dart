enum AppRoute {
  auth,
  todoList,
  createToDo
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.auth:
        return "/Auth";
      case AppRoute.todoList:
        return "/todoList";
      case AppRoute.createToDo:
        return "/createTodo";

      default:
        return "/Auth";
    }
  }
}