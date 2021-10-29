import 'package:dalotee/data/local/pref_repository.dart';
import 'package:dalotee/data/remote/api_service.dart';

import 'model/response/base/base_response.dart';
import 'model/response/demo_response.dart';

class AppRepository {
  // Remote
  final ApiService apiService;

  // Local: Pref & Database
  final PrefRepository prefRepository;

  AppRepository({required this.apiService, required this.prefRepository});

  Future<Result<DemoResponse, Exception>> getDemo() => apiService.getDemo();
}
