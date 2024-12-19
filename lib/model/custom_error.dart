class CustomError extends Error {
  final int statsCode;
  final String message;

  CustomError(this.statsCode, this.message);

  @override
  String toString() => message;
}