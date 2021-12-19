import 'app.dart';
import 'configs/flavor.dart';

void main() async {
  var flavorConfig = FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: "http://localhost:5000/",
      ));
  return MyApp.appRunner(flavorConfig);
}
