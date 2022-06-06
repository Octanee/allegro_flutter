class AllegroApiException implements Exception {
  final String message;
  final int? code;

  AllegroApiException({required this.message, this.code});

  @override
  String toString() {
    return '$runtimeType { $code - $message}';
  }
}
