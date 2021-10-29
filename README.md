# dalotee
  
## DEVELOPMENT  
### Run Debug  
```bash  
flutter run --flavor dev -t lib/main.dart
```  
### Run Release  
```bash  
flutter run --release --flavor dev -t lib/main.dart  
```  
### Build Debug  
```bash  
flutter build <OS> --flavor dev -t lib/main.dart  
```  
### Build Release  
```bash  
flutter build <OS> --release --flavor dev -t lib/main.dart  
```  
## PRODUCTION  
### Run Debug  
```bash  
flutter run --flavor prod -t lib/main-prod.dart  
```  
### Run Release  
```bash  
flutter run --release --flavor prod -t lib/main-prod.dart  
```  
### Build Debug  
```bash  
flutter build <OS> --flavor prod -t lib/main-prod.dart  
```  
### Build Release  
```bash  
flutter build <OS> --release --flavor prod -t lib/main-prod.dart  
```  
  
## Generating Files  
### Build  
```bash  
flutter pub run build_runner build --delete-conflicting-outputs  
```  
  
### Watch  
```bash  
flutter pub run build_runner watch --delete-conflicting-outputs  
```  
  
### Generate localization  
```bash  
flutter pub run intl_utils:generate
```  

### Generate icons  
```bash  
flutter pub run flutter_launcher_icons:main
```  

### Generate images   
```bash  
flutter packages pub run build_runner build
```  

## Project Structure
bloc/: Reusable blocs  
commons/: mixins (loading view, post frame callback,...), helper classes  
configs/: global constants, flavors, routes, IoC  

data/local/: Local repositories like SharedPreferences, sqflite  

data/remote/: Remote repositories  
data/remote/api_service_client.dart: Define http interceptors  
data/remote/api_service_helper.dart: Define base request handling  
data/remote/api_service.dart: Define specific requests  

data/model/: Model classes  

l10n/: String values  

presentation/: Presentation layer contains pages, dialogs, custom widgets,...  

utils/: Utility classes like string utils, network utils, bitmap utils,...  

values/: Colors, dimens, font sizes,...  
