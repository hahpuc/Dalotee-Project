class BaseResponseData<T> {
  late final String errorCode;
  late final String errorMsg;
  late final T? data;

  bool isSuccessful() {
    return true;
  }
}

class Result<T extends BaseResponseData, V extends Exception> {
  T? response;
  V? exception;
  Result({required this.response, required this.exception});

  bool isSuccessful() {
    if (exception == null) {
      return true;
    }
    return false;
  }
}
