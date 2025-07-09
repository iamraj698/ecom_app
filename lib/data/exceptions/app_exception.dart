class AppException implements Exception {
  final String message;
  AppException({required this.message});

  @override
  String toString() {
    return "Error: $message";
  }
}

class FetchDataException extends AppException {
  FetchDataException({String message = "Error During Communication"})
      : super(message: message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException({String? message}) : super(message: "Un Authorized");
}

class BadRequestException extends AppException {
  BadRequestException({String message = "Bad Request"})
      : super(message: message);
}

class InternalServerException extends AppException {
  InternalServerException({String message = "Internal Server Error"})
      : super(message: message);
}

class NoInternetException extends AppException {
  NoInternetException({String message = "No internet connection"})
      : super(message: message);
}

class TimeoutException extends AppException {
  TimeoutException({String message = "Request timed out"})
      : super(message: message);
}

class NotFoundException extends AppException {
  NotFoundException({String message = "Resource not found"})
      : super(message: message);
}
