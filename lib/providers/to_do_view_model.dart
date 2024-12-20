import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_app/api/requests/post/todo/add_to_do_request.dart';
import 'package:spotify_app/api/requests/post/todo/delete_to_do_request.dart';
import 'package:spotify_app/api/requests/post/todo/fetch_to_dos_request.dart';
import 'package:spotify_app/api/requests/post/todo/update_to_do_request.dart';
import 'package:spotify_app/model/custom_exception.dart';
import 'package:spotify_app/model/to_do_model.dart';
import '../api/service/api_service.dart';

part 'to_do_view_model.g.dart';

@riverpod
class ToDoViewModel extends _$ToDoViewModel {
  final ApiService _apiService = ApiService();

  @override
  Future<List<ToDoModel>> build() async {
    await fetchToDos(); // 初回取得
    return state.value ?? [];
  }

  // ToDoを取得
  Future<void> fetchToDos() async {
    state = const AsyncValue.loading();
    final fetchToDosRequest = FetchToDosRequest();
    final result = await _apiService(fetchToDosRequest);

    result.when(
        success: (Map<String, dynamic>? json) async {
          final List<dynamic> todosJson = json!['todos'];
          final List<ToDoModel> todos = todosJson
              .map((todoJson) => ToDoModel.fromJson(todoJson as Map<String, dynamic>))
              .toList();
          state = AsyncValue.data(todos);
        },
        exception: (CustomException error) {
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // ToDoを新規作成
  Future<void> addTodo(String title) async {
    state = const AsyncValue.loading();
    final addToDoRequest = AddToDoRequest(title);
    final result = await _apiService(addToDoRequest);

    result.when(
        success: (Map<String, dynamic>? json) async {
          final newToDo = ToDoModel.fromJson(json!);
          final currentList = state.value ?? [];
          final updatedList = [...currentList, newToDo];
          state = AsyncValue.data(updatedList);
        },
        exception: (CustomException error) {
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // ToDoを削除
  Future<void> removeTodo(int id) async {
    state = const AsyncValue.loading();
    final deleteToDoRequest = DeleteToDoRequest(id);
    final result = await _apiService(deleteToDoRequest);

    result.when(
        success: (Map<String, dynamic>? _) async {
          final updatedList = state.value?.where((todo) => todo.id != id).toList() ?? [];
          state = AsyncValue.data(updatedList);
        },
        exception: (CustomException error) {
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // ToDoを更新
  Future<void> updateTodo(int id, String newTitle, bool isCompleted) async {
    state = const AsyncValue.loading();
    final toDoModel = ToDoModel(id: id, title: newTitle, isCompleted: isCompleted);
    final updateToDoRequest = UpdateToDoRequest(toDoModel);
    final result = await _apiService(updateToDoRequest);

    result.when(
        success: (Map<String, dynamic>? _) async {
          final currentList = state.value ?? [];
          final updatedList = currentList.map((todo) {
            return todo.id == id ? todo.copyWith(title: newTitle, isCompleted: isCompleted) : todo;
          }).toList();
          state = AsyncValue.data(updatedList);
        },
        exception: (CustomException error) {
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }
}