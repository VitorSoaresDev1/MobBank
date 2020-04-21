import 'package:flutter/foundation.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/services/authentication_service.dart';
import 'package:mobbank/services/dialog_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/constants/route_names.dart';

import 'base_model.dart';

class SignInViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future logIn({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.replaceWith(DashBoardRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Falha no Login',
          description: 'Falha no Login. Por favor, tente novamente.',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Falha no Login',
        description: result,
      );
    }
  }
}
