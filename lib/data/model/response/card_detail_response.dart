import 'package:dalotee/data/model/response/get_card_category_response.dart';

import 'base/base_response.dart';

class GetCardByNumberResponse
    extends BaseResponseData<GetCardByNumberResponseData> {
  @override
  GetCardByNumberResponseData parseData(dynamic mapData) {
    return GetCardByNumberResponseData.fromJson(mapData);
  }
}

class GetCardByNumberResponseData {
  int? code;
  List<CardResponseModel>? data;

  GetCardByNumberResponseData({
    this.code,
    this.data,
  });

  GetCardByNumberResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new CardResponseModel.fromJson(v));
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
