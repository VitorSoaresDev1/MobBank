import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobbank/components/widgets/card_list_view.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/services/bank_card_service.dart';
import 'package:mobbank/store/card_list_length.dart';

import '../models/usuario.dart';

class Dashboard extends StatefulWidget {
  final List<dynamic> arguments;

  Dashboard({
    @required this.arguments,
  });

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Usuario _user = widget.arguments[0];
    final BankCardService _bankCardService = locator<BankCardService>();
    final CardListLength listLength = CardListLength();

    print(_user.getId().toString());
    print(_user.getEmail());
    print(_user.getNome());
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${_user.getNome().split(' ')[0]}'),
        elevation: 100,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: <Color>[
                    Color.fromRGBO(213, 232, 231, 1),
                    Color.fromRGBO(234, 255, 254, 1)
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds),
                child: Text(
                  'Escolha uma conta para acessar: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      wordSpacing: 2,
                      color: Colors.white70,
                      fontSize: 24,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
          CardsListWheel(user: _user),
        ],
      ),
    );
  }
}
