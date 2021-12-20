import 'package:dalotee/data/model/response/base/base_response.dart';

class GetQuestionResponse extends BaseResponseData<GetQuestionResponseData> {
  @override
  GetQuestionResponseData parseData(dynamic mapData) {
    return GetQuestionResponseData.fromJson(mapData);
  }
}

class GetQuestionResponseData {
  int? code;
  List<QuestionResponse>? data;

  GetQuestionResponseData({
    this.code,
    this.data,
  });

  GetQuestionResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      (json['data'] as List).forEach((v) {
        data?.add(new QuestionResponse.fromJson(v));
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

class QuestionResponse {
  String? id;
  String? question;

  QuestionResponse({
    this.id,
    this.question,
  });

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['question'] = this.question;
    return data;
  }
}
