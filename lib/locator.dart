import 'package:get_it/get_it.dart';
import 'package:mobbank/services/authentication_service.dart';
import 'package:mobbank/services/dialog_service.dart';
import 'package:mobbank/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
}
