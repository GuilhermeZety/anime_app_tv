class ServerException implements Exception {
  final String? message;
  final StackTrace? stackTrace;
  ServerException({
    this.message,
    this.stackTrace,
  });
}

class DBException implements Exception {
  final String? message;
  final StackTrace? stackTrace;
  DBException({
    this.message,
    this.stackTrace,
  });
}
