import 'app.dart';
import 'configs/flavor.dart';

void main() async {
  var flavorConfig = FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: "",
      ));
  return MyApp.appRunner(flavorConfig);
}
