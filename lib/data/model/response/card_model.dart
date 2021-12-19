import 'package:dalotee/data/model/response/base/base_response.dart';

class Card extends BaseResponseData<CardData> {
  @override
  CardData parseData(data) {
    // TODO: implement parseData
    throw UnimplementedError();
  }
}

class CardData {
  final String? name;
  final String front;
  final String back;
  final String? description;
  final String? meaning;
  final String? category;

  CardData(
      {this.name,
      required this.front,
      required this.back,
      this.description,
      this.meaning,
      this.category});
  factory CardData.fromMap(Map<String, dynamic> map) {
    return CardData(
      name: map["name"] as String,
      front: map["front"] as String,
      back: map["back"] as String,
      description: map["description"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "front": this.front,
      "back": this.back,
      "description": this.description
    };
  }
}
