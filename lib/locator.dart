import 'package:get_it/get_it.dart';
import 'package:heron_delivery/core/providers/cart_provider.dart';
import 'package:heron_delivery/core/services/abst_user_service.dart';
import 'package:heron_delivery/core/services/user_firebase_service_impl.dart';
import 'package:heron_delivery/core/viewmodels/home_view_model.dart';
import 'core/services/abst_item_service.dart';
import 'core/services/auth/auth_firebase_service_impl.dart';
import 'core/services/auth/abst_auth.dart';
import 'core/services/item_firebase_service_impl.dart';
import 'core/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<AbstAuth>(() => AuthServiceFirebase());
  locator
      .registerLazySingleton<AbstItemService>(() => ItemServiceFirebaseImpl());
  locator
      .registerLazySingleton<AbstUserService>(() => UserServiceFirebaseImpl());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => CartProvider());
}
