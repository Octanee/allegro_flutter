class LogInException implements Exception {
  final String message;

  const LogInException([
    this.message = 'An unknown exception occured.',
  ]);

  factory LogInException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInException(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInException(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInException(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInException(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInException();
    }
  }
}
