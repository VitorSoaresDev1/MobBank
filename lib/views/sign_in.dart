import 'package:flutter/material.dart';
import 'package:mobbank/animation/fade_animation.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/dialog_models.dart';
import 'package:mobbank/services/authentication_service.dart';
import 'package:mobbank/services/dialog_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/constants/route_names.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: FadeAnimation(
                  1,
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/purple_wave.png"),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Center(
                    child: Text(
                      "Mob Bank",
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          letterSpacing: 12,
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FadeAnimation(
                  1,
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Usuário",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Senha",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: FadeAnimation(
                    1,
                    FlatButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return PasswordAuthDialog(
                              onConfirm: (String email) async =>
                                  await _authenticationService.forgotPassword(
                                      email: email));
                        },
                      ),
                      child: Text(
                        "Esqueci minha senha",
                        style: TextStyle(
                          color: Colors.pink[200],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                  1,
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(49, 39, 79, 1),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FadeAnimation(
                  1,
                  Center(
                    child: FlatButton(
                      onPressed: () =>
                          _navigationService.navigateTo(SignUpRoute),
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(
                          color: Colors.pink[200],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
