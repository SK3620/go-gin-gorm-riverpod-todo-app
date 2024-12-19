class CustomException implements Exception {
  final int statsCode;
  final String title = 'エラーが発生しました。';
  final String message;

  CustomException(
    this.statsCode,
    this.message,
  );
}