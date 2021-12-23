import 'package:dalotee/data/model/response/base/base_response.dart';

class UserResponse extends BaseResponseData<UserResponseData> {
  // UserResponseData parseData(data) {
  //   return UserResponseData.fromMap(map)
  // }
  @override
  UserResponseData parseData(dynamic mapData) {
    return UserResponseData.fromMap(mapData);
  }
}

class UserResponseData {
  final String? avatar;
  final int? userId;
  final String? name;
  final String? phoneNumber;
  final DateTime? birthDay;

  UserResponseData(
      {this.avatar, this.userId, this.name, this.phoneNumber, this.birthDay});

  factory UserResponseData.fromMap(Map<String, dynamic> map) {
    return UserResponseData(
        avatar: map["avatar"] as String,
        userId: map["userId"] as int,
        name: map["name"] as String,
        phoneNumber: map["phoneNumber"] as String,
        birthDay: DateTime.parse(map["birthDay"]));
  }

  Map<String, dynamic> toMap() {
    return {
      "avatar": this.avatar,
      "userId": this.userId,
      "name": this.name,
      "phoneNumber": this.phoneNumber,
      "birthDay": this.birthDay?.toIso8601String(),
    };
  }
}
