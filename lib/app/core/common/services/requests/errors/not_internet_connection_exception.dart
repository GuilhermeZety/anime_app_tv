class NotInternetConnectionException implements Exception {
  final String message;

  NotInternetConnectionException({this.message = 'No internet connection'});
}