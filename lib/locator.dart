import 'package:get_it/get_it.dart';
import 'core/services/authentication_service.dart';
import 'core/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthServiceFirebase());
}
