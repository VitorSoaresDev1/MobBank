import 'package:flutter/foundation.dart';
import 'package:mobbank/http/webclients/usuario_webclient.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/usuario.dart';
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
  final UsuarioWebClient _usuarioWebClient = locator<UsuarioWebClient>();

  Future signUp({
    @required String email,
    @required String nome,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signupWithEmail(
        email: email, password: password);

    if (result is bool) {
      if (result) {
        Usuario user =
            new Usuario(id: 0, nome: nome, email: email, senha: password);
        await _usuarioWebClient.save(user);
        user = await _usuarioWebClient.findOneByEmail(user.email);
        _dialogService.showDialog(
            title: 'Sucesso', description: 'Sua conta foi criada com Sucesso');
        _navigationService.pop();
        _navigationService.replaceWith(DashBoardRoute, arguments: [user]);
        setBusy(false);
      } else {
        setBusy(false);
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
