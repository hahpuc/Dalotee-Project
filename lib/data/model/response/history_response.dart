import 'package:dalotee/data/model/response/get_card_category_response.dart';

class HistoryResponse {
  String? time;
  CardResponseModel? data;

  HistoryResponse({
    this.time,
    this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      HistoryResponse(
        time: json["time"] == null ? null : json["time"],
        data: json["data"] == null
            ? null
            : CardResponseModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null ? null : time,
        "data": data == null ? null : data?.toJson(),
      };
}
