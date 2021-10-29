import 'package:dalotee/data/exceptions/api_exception.dart';
import 'package:dalotee/data/exceptions/app_exception.dart';

extension ExceptionExtension on Exception {
  String apiErrorMessage() {
    String msg;
    if (this is NoInternetException) {
      msg = "No internet connection";
    } else if (this is ServerException) {
      msg = "Internal server error";
    } else {
      msg = "Unknown";
    }
    return msg;
  }
}
