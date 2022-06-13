class DatabaseException implements Exception {
  final String message;
  final int? code;

  DatabaseException({required this.message, this.code});

  @override
  String toString() {
    return '$runtimeType { $code - $message}';
  }
}
