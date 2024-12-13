class ApiUrl {

  /// 今回はローカルサーバーのみ
  static const String baseUrl = 'localhost::8000hogehoge';

  /// 認証
  static const String signUp = '/api/sign_up';
  static const String signIn = '/api/sign_in';

  /// ToDo
  static const String fetchToDos = '/api/to_do/get';
  static const String addToDo = '/api/to_do/add';
  static const String editToDo = '/api/to_do/edit';
  static const String deleteToDo = '/api/to_do/delete';
  static const String toggleCompletion = '/api/to_do/toggle_completion';
}