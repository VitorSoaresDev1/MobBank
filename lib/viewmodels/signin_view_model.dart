import 'package:flutter/foundation.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/authentication_service.dart';
import 'package:mobbank/services/dialog_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/services/user_service.dart';

import 'base_model.dart';

class SignInViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UsersService _usersService = locator<UsersService>();

  Future logIn({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    if (result is bool) {
      if (result) {
        Usuario user;
        try {
          user = await _usersService.getUsuario(email);
          _navigationService.replaceWith(DashBoardRoute, arguments: [user]);
        } catch (e) {
          await _dialogService.showDialog(
            title: 'Falha no Login',
            description: "Falha na comunicação com o servidor.",
          );
          setBusy(false);
        }
      } else {
        await _dialogService.showDialog(
          title: 'Falha no Login',
          description: 'Falha no Login. Por favor, tente novamente.',
        );
        setBusy(false);
      }
    } else {
      await _dialogService.showDialog(
        title: 'Falha no Login',
        description: result,
      );
      setBusy(false);
    }
  }
}
