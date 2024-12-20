import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_app/api/requests/post/auth/sign_in_request.dart';
import 'package:spotify_app/api/requests/post/auth/sign_up_request.dart';
import 'package:spotify_app/api/service/api_service.dart';
import 'package:spotify_app/api/service/common_http_router.dart';
import 'package:spotify_app/model/auth_model.dart';
import 'package:spotify_app/model/custom_exception.dart';
import 'package:spotify_app/config/config.dart';
import 'package:spotify_app/config/storage.dart';

part 'auth_view_model.g.dart';

// ユーザー認証のロジックを管理するViewModel
@riverpod
class AuthViewModel extends _$AuthViewModel {
  // APIリクエストを実行するためのサービスクラス
  final ApiService _apiService = ApiService();

  @override
  Future<bool> build() async {
    // 初期状態では認証が完了していないため、falseを返す
    return false;
  }

  // 共通の認証リクエスト処理
  //`CommonHttpRouter`型のリクエストを受け取り、APIを呼び出す
  // 成功時: バックエンド（Golang）から受け取ったJWT認証トークンを端末のローカル上に保存し、stateに認証完了(true)を設定して、画面遷移
  // 失敗時: stateにエラー（カスタム例外クラス）を設定して、エラー状態にする（エラーアラートを表示）
  Future<void> _handleAuthRequest(CommonHttpRouter request) async {
    // 状態をローディング中に設定
    state = const AsyncValue.loading();
    // APIリクエスト実行
    final result = await _apiService(request);

    // Result型でリクエスト結果をハンドリング
    result.when(
        success: (Map<String, dynamic>? json) async {
          // JSONデータをAuthModelに変換
          final authModel = AuthModel.fromJson(json!);
          // JWTトークンをセキュアストレージに保存
          await SecureStorage().save(Config.secureStorageJwtTokenKey, authModel.jwtToken ?? '');
          // 認証成功として状態を更新
          state = const AsyncValue.data(true);
        },
        exception: (CustomException error) {
          // エラーの場合、状態をエラーとして更新
          state = AsyncError(error, StackTrace.empty);
        }
    );
  }

  // サインアップ
  Future<void> signUp(String username, String email, String password) async {
    final authModel = AuthModel(username: username, email: email, password: password);
    // リクエストする情報を組み立てる
    final signUpRequest = SignUpRequest(authModel);
    _handleAuthRequest(signUpRequest);
  }

  // サインイン
  Future<void> signIn(String email, String password) async {
    final authModel = AuthModel(email: email, password: password);
    // リクエストする情報を組み立てる
    final signInRequest = SignInRequest(authModel);
    _handleAuthRequest(signInRequest);
  }
}