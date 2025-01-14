class Config {
  //api timeout時間
  static Duration apiDuration = const Duration(seconds: 35);

  //api取得後のログインtoken保存場所のkey
  static String secureStorageJwtTokenKey = "jwt-token-key";

  //api取得後のユーザーネーム保存場所のkey
  static String secureStorageUserKey = "user-key";
}
