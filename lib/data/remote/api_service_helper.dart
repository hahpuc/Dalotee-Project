import 'dart:convert';
import 'dart:developer';

import 'package:dalotee/data/exceptions/api_exception.dart';
import 'package:dalotee/data/exceptions/app_exception.dart';
import 'package:dalotee/data/model/response/base/base_response.dart';
import 'package:dalotee/data/remote/api_service_client.dart';
import 'package:dalotee/utils/network_utils.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class ApiServiceHelper {
  static final ApiServiceHelper _singleton = ApiServiceHelper._internal();

  factory ApiServiceHelper() {
    return _singleton;
  }

  ApiServiceHelper._internal();

  Client _client = ApiServiceClient();

  ///
  /// Base function to handle requests
  /// request: GET, POST, PUT, DELETE
  /// return: Result<T extends BaseResponse, Exception>
  ///
  Future<Result<T, Exception>> handleResponse<T extends BaseResponseData>(
      {required Function request}) async {
    Result<T, Exception> result = Result(response: null, exception: null);

    // Check network before each request
    if (await NetworkUtils.isNetworkAvailable() == false) {
      result.exception = NoInternetException();
      return result;
    }

    // Try requesting
    try {
      result.response = await request.call();
    } on Exception catch (e) {
      result.exception = e;
      print("-----> Exception ${e.toString()}");
    } catch (e) {
      result.exception = UnknownApiException();
      print("-----> Exception ${e.toString()}");
    } finally {
      // Make sure to close client after each request
      _client.close();
    }
    return result;
  }

  ///
  /// Base GET method
  /// Exception will be catched in handleResponse()
  ///
  Future<dynamic> get(
      {required String url, Map<String, String>? headers}) async {
    var responseJson;
    final response = await _client
        .get(Uri.parse(url), headers: headers)
        .timeout(Duration(seconds: ApiConfigs.TIME_OUT_SECONDS));

    print("----> Url: $url");
    print("----> Method: GET");
    print("----> Headers: $headers");
    log("-----> Response ${response.body}");
    responseJson = _checkHttpResponse(response);
    return responseJson;
  }

  ///
  /// Base POST method
  /// Exception will be catched in handleResponse()
  ///
  Future<dynamic> post(
      {required String url,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    var responseJson;
    final response = await _client
        .post(Uri.parse(url), headers: headers, body: body, encoding: encoding)
        .timeout(Duration(seconds: ApiConfigs.TIME_OUT_SECONDS));

    print("----> Url: $url");
    print("----> Method: POST");
    print("----> Headers: $headers");
    print("----> Body: $body");
    print("-----> Response ${response.body}");

    responseJson = _checkHttpResponse(response);
    return responseJson;
  }

  ///
  /// Base PUT method
  /// Exception will be catched in handleResponse()
  ///
  Future<dynamic> put(
      {required String url,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    var responseJson;
    final response = await _client
        .put(Uri.parse(url), headers: headers, body: body, encoding: encoding)
        .timeout(Duration(seconds: ApiConfigs.TIME_OUT_SECONDS));

    print("----> Url: $url");
    print("----> Method: PUT");
    print("----> Headers: $headers");
    print("----> Body: $body");
    print("-----> Response ${response.body}");
    responseJson = _checkHttpResponse(response);

    return responseJson;
  }

  ///
  /// Base DELETE method
  /// Exception will be catched in handleResponse()
  ///
  Future<dynamic> delete(
      {required String url,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    var responseJson;
    final response = await _client
        .delete(Uri.parse(url),
            headers: headers, body: body, encoding: encoding)
        .timeout(Duration(seconds: ApiConfigs.TIME_OUT_SECONDS));
    responseJson = _checkHttpResponse(response);
    return responseJson;
  }

  dynamic _checkHttpResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 500:
        throw ServerException();
      default:
        throw UnknownApiException();
    }
  }
}
