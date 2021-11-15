class AppException implements Exception {
  final String message;
  final String prefix;
  final String url;

  AppException(this.message, this.prefix, this.url);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message!, 'Bad Request', url!);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message!, 'Unable to process', url!);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message!, 'Api not responded', url!);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message!, 'Unauthorized request', url!);
}

class NumberAlreadyExistException extends AppException {
  NumberAlreadyExistException([String? message, String? url])
      : super(message!, 'Number already exist', url!);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(message!, 'Number already exist', url!);
}