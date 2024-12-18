class ApiUrl {

  /// 今回はローカルサーバーのみ
  static const String baseUrl = 'http://localhost:8080';

  /// 認証
  static const String signUp = '/auth/sign_up';
  static const String signIn = '/auth/login';

  /// ToDo
  static const String fetchToDos = '/todos';
  static const String addToDo = '/todos';
  static const String editToDo = '/todos';
  static const String deleteToDo = '/todos';
}