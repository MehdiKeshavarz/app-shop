class ApiException implements Exception {
  String? message;
  int? statusCode;

  ApiException({this.message, this.statusCode});
}
