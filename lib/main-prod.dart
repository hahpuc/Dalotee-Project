import 'app.dart';
import 'configs/flavor.dart';

void main() async {
  var flavorConfig = FlavorConfig(
      flavor: Flavor.PRODUCTION,
      values: FlavorValues(
        baseUrl: "",
      ));
  return MyApp.appRunner(flavorConfig);
}
