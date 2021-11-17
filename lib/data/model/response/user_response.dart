import 'package:dalotee/data/model/response/base/base_response.dart';

class UserResponse extends BaseResponseData<UserResponseData> {
  @override
  UserResponseData parseData(data) {
    throw UnimplementedError();
  }
}

class UserResponseData {
  final int? userId;
  final String? name;
  final String? phoneNumber;
  final DateTime? birthDay;

  UserResponseData({this.userId, this.name, this.phoneNumber, this.birthDay});

  factory UserResponseData.fromMap(Map<String, dynamic> map) {
    return UserResponseData(
        userId: map["userId"] as int,
        name: map["name"] as String,
        phoneNumber: map["phoneNumber"] as String,
        birthDay: map["birthDay"] as DateTime);
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": this.userId,
      "id": this.name,
      "phoneNumber": this.phoneNumber,
      "birthDay": this.birthDay
    };
  }
}
