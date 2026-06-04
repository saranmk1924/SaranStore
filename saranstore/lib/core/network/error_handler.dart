import 'package:dio/dio.dart';

class ErrorHandler {
  String handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Timeout";
      case DioExceptionType.sendTimeout:
        return "Receive Timeout";
      case DioExceptionType.receiveTimeout:
        return "Server is taking too long to respond";
      case DioExceptionType.connectionError:
        return "No Internet conection :(";
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;

        switch (statusCode) {
          case 400:
            return "Bad request";
          case 401:
            return "Unauthorized access";
          case 403:
            return "Access denied";
          case 404:
            return "Data not found";
          case 500:
            return "Server Error";
          default:
            return "Unexpected server error";
        }
      case DioExceptionType.cancel:
        return "Request cancelled";
      default:
        return "Something went wrong :(";
    }
  }
}
