import 'package:flutter/foundation.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/services/authentication_service.dart';
import 'package:mobbank/services/dialog_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/constants/route_names.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signupWithEmail(
        email: email, password: password);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _dialogService.showDialog(
            title: 'Sucesso', description: 'Sua conta foi criada com Sucesso');
        _navigationService.pop();
        _navigationService.replaceWith(DashBoardRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Falha no Cadastro',
          description:
              'Falha no cadastro. Por favor, tente novamente em alguns momentos.',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Falha no Cadastro',
        description: result,
      );
    }
  }
}
