import 'package:http/http.dart';

///
/// Set up interceptors
///
class ApiServiceClient extends BaseClient {
  ApiServiceClient();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    // Intercept each call and do sth
    //
    // Example: Add access token for each request
    // if (userAccessToken.isNotEmpty) {
    //   request.headers.putIfAbsent('Authorization', () => userAccessToken);
    // }

    return request.send();
  }
}
