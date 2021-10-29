import 'package:get_it/get_it.dart';
import 'package:dalotee/configs/flavor.dart';
import 'package:dalotee/data/app_repository.dart';
import 'package:dalotee/data/local/pref_repository.dart';
import 'package:dalotee/data/remote/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future setupServiceLocator() async {
  // PrefRepository
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PrefRepository>(
      () => PrefRepository(sharedPreferences));

  // ApiService
  locator.registerLazySingleton<ApiService>(
      () => ApiService(baseUrl: FlavorConfig.instance.values.baseUrl));

  // AppRepository
  locator.registerLazySingleton<AppRepository>(() =>
      AppRepository(apiService: locator.get(), prefRepository: locator.get()));
}
