import 'package:dalotee/data/model/response/base/base_response.dart';

class GetCardByCategoryResponse
    extends BaseResponseData<GetCardByCategoryResponseData> {
  @override
  GetCardByCategoryResponseData parseData(dynamic mapData) {
    return GetCardByCategoryResponseData.fromJson(mapData);
  }
}

class GetCardByCategoryResponseData {
  int? code;
  List<CardResponseModel>? data;

  GetCardByCategoryResponseData({
    this.code,
    this.data,
  });

  GetCardByCategoryResponseData.fromJson(Map<String, dynamic> json) {
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

//-----------

class CardResponseModel {
  int? id;
  String? name;
  int? number;
  List<ImagesResponse>? images;
  CategoryResponse? category;
  KeywordResponse? keyword;
  String? content;
  String? prophecy;
  String? advice;

  CardResponseModel({
    this.id,
    this.name,
    this.number,
    this.images,
    this.category,
    this.keyword,
    this.content,
    this.prophecy,
    this.advice,
  });

  CardResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    number = json['number'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(new ImagesResponse.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new CategoryResponse.fromJson(json['category'])
        : null;
    keyword = json['keyword'] != null
        ? new KeywordResponse.fromJson(json['keyword'])
        : null;
    content = json['content'];
    prophecy = json['prophecy'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    if (this.images != null) {
      data['images'] = this.images?.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category?.toJson();
    }
    if (this.keyword != null) {
      data['keyword'] = this.keyword?.toJson();
    }
    data['content'] = this.content;
    data['prophecy'] = this.prophecy;
    data['advice'] = this.advice;
    return data;
  }
}

//-----------

class ImagesResponse {
  String? imageUrl;
  String? cloudinaryId;

  ImagesResponse({
    this.imageUrl,
    this.cloudinaryId,
  });

  ImagesResponse.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    cloudinaryId = json['cloudinary_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['cloudinary_id'] = this.cloudinaryId;
    return data;
  }
}

class CategoryResponse {
  String? id;
  String? name;

  CategoryResponse({
    this.id,
    this.name,
  });

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class KeywordResponse {
  String? id;
  List<KeyWordData>? keyword;

  KeywordResponse({
    this.id,
    this.keyword,
  });

  KeywordResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['keyword'] != null) {
      keyword = [];
      json['keyword'].forEach((v) {
        keyword?.add(new KeyWordData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.keyword != null) {
      data['keyword'] = this.keyword?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KeyWordData {
  String? id;
  String? title;
  String? content;

  KeyWordData({
    this.id,
    this.title,
    this.content,
  });

  KeyWordData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
