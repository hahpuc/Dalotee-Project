import 'package:dalotee/data/model/response/base/base_response.dart';

class Card extends BaseResponseData<CardData> {}

class CardData {
  final String front;
  final String back;

  CardData({required this.front, required this.back});
  factory CardData.fromMap(Map<String, dynamic> map) {
    return CardData(
      front: map["front"] as String,
      back: map["back"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {"front": this.front, "back": this.back};
  }
}
