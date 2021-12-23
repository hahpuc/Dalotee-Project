import 'app.dart';
import 'configs/flavor.dart';

void main() async {
  var flavorConfig = FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: "http://192.168.1.4:5000",
      ));
  return MyApp.appRunner(flavorConfig);
}
