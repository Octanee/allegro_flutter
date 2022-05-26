class LogOutException implements Exception {
  final String message;

  const LogOutException([
    this.message = 'An unknown exception occured.',
  ]);

  factory LogOutException.fromCode(String code) {
    switch (code) {
      default:
        return const LogOutException();
    }
  }
}
