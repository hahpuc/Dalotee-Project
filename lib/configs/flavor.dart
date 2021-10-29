/*
Available commands:
flutter run --flavor dev -t lib/main.dart
flutter run --flavor prod -t lib/main_prod.dart
 */

enum Flavor { DEV, PRODUCTION }

class FlavorValues {
  FlavorValues({
    required this.baseUrl,
  });

  final String baseUrl;
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;
  static late FlavorConfig _instance;

  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _instance = FlavorConfig._internal(flavor, values);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.values);

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;

  static bool isDevelopment() => _instance.flavor == Flavor.DEV;
}
