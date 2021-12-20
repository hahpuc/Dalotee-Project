import 'package:dalotee/data/model/response/base/base_response.dart';
import 'package:dalotee/data/model/response/card_detail_response.dart';
import 'package:dalotee/data/model/response/get_card_category_response.dart';
import 'package:dalotee/data/model/response/demo_response.dart';
import 'package:dalotee/data/model/response/spread/get_content_question_response.dart';
import 'package:dalotee/data/remote/api_service_helper.dart';

class ApiConfigs {
  static const TIME_OUT_SECONDS = 30;
}

class ApiPath {
  static const DEMO = "/v1/abc";
  static const GET_CARD_BY_CATEGORY = "/card/category/";
  static const GET_CARD_BY_NUMBER = "/card/number/";
  static const GET_CONTENT_QUESTION = "/contentquestions/";
}

class ApiService {
  final String baseUrl;
  final ApiServiceHelper _apiServiceHelper = ApiServiceHelper();

  ApiService({required this.baseUrl});

  Future<Result<DemoResponse, Exception>> getDemo() async {
    return _apiServiceHelper.handleResponse<DemoResponse>(request: () async {
      var response = await _apiServiceHelper.get(
          url: 'https://jsonplaceholder.typicode.com/albums/1');
      // Parse data here to BaseResponse
      return DemoResponse.fromMap(response);
    });
  }

  Future<Result<GetCardByCategoryResponse, Exception>> getCardByCategory(
      String categoryId) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.get(
          url: baseUrl + ApiPath.GET_CARD_BY_CATEGORY + categoryId);

      return GetCardByCategoryResponse().tryParse(response);
    });
  }

  Future<Result<GetCardByNumberResponse, Exception>> getCardByNumber(
      String number) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.get(
          url: baseUrl + ApiPath.GET_CARD_BY_NUMBER + number);

      return GetCardByNumberResponse().tryParse(response);
    });
  }

  Future<Result<GetContentQuestionResponse, Exception>>
      getContentQuestionByType(String typeID) async {
    return _apiServiceHelper.handleResponse(request: () async {
      var response = await _apiServiceHelper.get(
          url: baseUrl + ApiPath.GET_CONTENT_QUESTION + typeID);

      return GetContentQuestionResponse().tryParse(response);
    });
  }
}
