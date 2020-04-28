import 'package:get_it/get_it.dart';
import 'package:mobbank/http/webclients/bank_card_webclient.dart';
import 'package:mobbank/http/webclients/usuario_webclient.dart';
import 'package:mobbank/services/authentication_service.dart';
import 'package:mobbank/services/bank_card_service.dart';
import 'package:mobbank/services/dialog_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/services/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UsuarioWebClient());
  locator.registerLazySingleton(() => UsersService());
  locator.registerLazySingleton(() => BankCardWebClient());
  locator.registerLazySingleton(() => BankCardService());
}
