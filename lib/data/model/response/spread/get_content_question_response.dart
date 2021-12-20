import 'package:dalotee/data/model/response/base/base_response.dart';

class GetContentQuestionResponse
    extends BaseResponseData<GetContentQuestionResponseData> {
  @override
  GetContentQuestionResponseData parseData(dynamic mapData) {
    return GetContentQuestionResponseData.fromJson(mapData);
  }
}

class GetContentQuestionResponseData {
  int? code;
  List<ContentQuestionResponse>? data;

  GetContentQuestionResponseData({
    this.code,
    this.data,
  });

  GetContentQuestionResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      (json['data'] as List).forEach((v) {
        data?.add(new ContentQuestionResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentQuestionResponse {
  String? id;
  String? contentQuestion;

  ContentQuestionResponse({
    this.id,
    this.contentQuestion,
  });

  ContentQuestionResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    contentQuestion = json['contentQuestion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['contentQuestion'] = this.contentQuestion;
    return data;
  }
}
