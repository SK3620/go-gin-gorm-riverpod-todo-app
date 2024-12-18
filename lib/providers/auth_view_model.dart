import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_app/api/requests/post/auth/sign_in_request.dart';
import 'package:spotify_app/api/requests/post/auth/sign_up_request.dart';
import 'package:spotify_app/api/service/api_service.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import 'package:spotify_app/model/auth_model.dart';
import 'package:spotify_app/model/failure_model.dart';
import 'package:spotify_app/widgets/config.dart';
import 'package:spotify_app/widgets/storage.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final ApiService _apiService = ApiService();

  @override
  Future<bool> build() async {
    // 認証完了か否か
    return false;
  }

  Future<void> _handleAuthRequest(CommonHttpRouter request) async {
    state = const AsyncValue.loading();
    final result = await _apiService(request);

    result.when(
        success: (Map<String, dynamic>? json) async {
          final authModel = AuthModel.fromJson(json!);
          await SecureStorage().save(Config.secureStorageJwtTokenKey, authModel.jwtToken ?? '');
          state = const AsyncValue.data(true);
        },
        error: (FailureModel error) {
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  Future<void> signUp(String username, String email, String password) async {
    final authModel = AuthModel(username: username, email: email, password: password);
    final signUpRequest = SignUpRequest(authModel);
    _handleAuthRequest(signUpRequest);
  }

  Future<void> signIn(String email, String password) async {
    final authModel = AuthModel(email: email, password: password);
    final signInRequest = SignInRequest(authModel);
    _handleAuthRequest(signInRequest);
  }
}