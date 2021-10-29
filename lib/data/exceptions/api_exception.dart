import 'app_exception.dart';

class ApiException extends AppException {}

class BadRequestException extends ApiException {}

class UnauthorisedException extends ApiException {}

class ServerException extends ApiException {}

class UnknownApiException extends ApiException {}
