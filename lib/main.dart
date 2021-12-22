import 'app.dart';
import 'configs/flavor.dart';

void main() async {
  var flavorConfig = FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: "http://ec02-171-242-37-80.ngrok.io",
      ));
  return MyApp.appRunner(flavorConfig);
}
