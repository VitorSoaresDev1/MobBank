import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobbank/components/widgets/progress.dart';
import 'package:mobbank/components/widgets/transaction_auth_dialog.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/http/webclients/deposit_webclient.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/deposit.dart';
import 'package:mobbank/models/dialog_models.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/deposit_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:uuid/uuid.dart';

class PagamentoForm extends StatefulWidget {
  final List<dynamic> arguments;

  const PagamentoForm({
    @required this.arguments,
  });

  @override
  _PagamentoFormState createState() => _PagamentoFormState();
}

class _PagamentoFormState extends State<PagamentoForm> {
  final TextEditingController _valueController = TextEditingController();
  final DepositService _depositService = locator<DepositService>();

  final String _depositId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final Usuario _user = widget.arguments[0];
    final BankCard _card = widget.arguments[1];
    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar um pagamento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Efetuando...',
                  ),
                ),
                visible: _sending,
              ),
              Text(
                'Titular: ',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 40),
                  Text(
                    '${_user.nome}',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Nº da conta: ',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 40),
                  Text(
                    '${_card.spacedAccountNumber}',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Pagar'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionAuthDialog(
                              onConfirm: (String password) {
                            final depositCreated = Deposit(_depositId, value,
                                _card.id, null, 2, password, DateTime.now());
                            _save(_depositService, depositCreated, password,
                                context, _user, _card);
                          });
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
      DepositService _depositService,
      Deposit depositCreated,
      String password,
      BuildContext context,
      Usuario _user,
      BankCard _card) async {
    setState(() {
      _sending = true;
    });

    final Deposit deposit = await _send(
        _depositService, depositCreated, password, context, _user, _card);

    _showSuccessfulMessage(deposit, context, _user, _card);
  }

  Future _showSuccessfulMessage(Deposit deposit, BuildContext context,
      Usuario _user, BankCard _card) async {
    final NavigationService _navigationService = locator<NavigationService>();
    if (deposit != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) =>
              SuccessDialog('O pagamento foi efetuado')).then((value) =>
          _navigationService
              .replaceWith(HomeViewRoute, arguments: [_card, _user]));
    }
  }

  Future<Deposit> _send(
      DepositService _depositService,
      Deposit depositCreated,
      String password,
      BuildContext context,
      Usuario _user,
      BankCard _card) async {
    return await _depositService.saveDeposit(depositCreated).catchError((e) {
      _showFailureMessage(context,
          message: 'Timeout submitting the transaction');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
  }

  Future _showFailureMessage(BuildContext context,
      {String message = 'Unknown Error'}) {
    return showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
