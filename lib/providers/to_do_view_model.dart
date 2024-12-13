import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_app/api/requests/post/todo/add_to_do_request.dart';
import 'package:spotify_app/api/requests/post/todo/delete_to_do_request.dart';
import 'package:spotify_app/api/requests/post/todo/fetch_to_dos_request.dart';
import 'package:spotify_app/api/requests/post/todo/toggle_completion_request.dart';
import 'package:spotify_app/api/requests/post/todo/update_to_do_request.dart';
import 'package:spotify_app/model/failure_model.dart';
import 'package:spotify_app/model/to_do_model.dart';
import '../api/service/api_service.dart';

part 'to_do_view_model.g.dart';

@riverpod
class ToDoViewModel extends _$ToDoViewModel {
  final ApiService _apiService = ApiService();

  @override
  Future<List<ToDoModel>> build() async {
    return [];
  }

  // ToDoを取得
  void fetchToDos() async {
    final fetchToDosRequest = FetchToDosRequest();
    final result = await _apiService(fetchToDosRequest);

    result.when(
        success: (Map<String, dynamic> json) async {
          final List<dynamic> todosJson = json['todos'];
          final List<ToDoModel> todos = todosJson.map((todoJson) {
            return ToDoModel.fromJson(todoJson);
          }).toList();
          state = AsyncValue.data(todos);
        },
        error: (FailureModel error) {
          print(error);
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // ToDoを追加
  void addTodo(String title) async {
    final addToDoRequest = AddToDoRequest(title);
    final result = await _apiService(addToDoRequest);

    result.when(
        success: (Map<String, dynamic> json) async {
          final newToDo = ToDoModel.fromJson(json);
          final currentList = state.value ?? [];
          final updatedList = [...currentList, newToDo];
          state = AsyncValue.data(updatedList);
        },
        error: (FailureModel error) {
          print(error);
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // ToDoを削除
  void removeTodo(int id) async {
    final deleteToDoRequest = DeleteToDoRequest(id);
    final result = await _apiService(deleteToDoRequest);

    result.when(
        success: (Map<String, dynamic> json) async {
          final updatedList = state.value?.where((todo) => todo.id != id).toList() ?? [];
          state = AsyncValue.data(updatedList);
        },
        error: (FailureModel error) {
          print(error);
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // ToDoを更新
  void updateTodo(int id, String newTitle) async {
    final toDoModel = ToDoModel(id: id, title: newTitle);
    final updateToDoRequest = UpdateToDoRequest(toDoModel);
    final result = await _apiService(updateToDoRequest);

    result.when(
        success: (Map<String, dynamic> json) async {
          final currentList = state.value ?? [];
          final updatedList = currentList.map((todo) {
            return todo.id == id ? todo.copyWith(title: newTitle) : todo;
          }).toList();
          state = AsyncValue.data(updatedList);
        },
        error: (FailureModel error) {
          print(error);
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // ToDoの完了状態を切り替え
  void toggleCompletion(int id) async {
    final toggleCompletionRequest = ToggleCompletionRequest(id);
    final result = await _apiService(toggleCompletionRequest);

    result.when(
        success: (Map<String, dynamic> json) async {
          final currentList = state.value ?? [];
          final updatedList = currentList.map((todo) {
            return todo.id == id ? todo.copyWith(isCompleted: !todo.isCompleted) : todo;
          }).toList();
          state = AsyncValue.data(updatedList);
        },
        error: (FailureModel error) {
          print(error);
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }
}