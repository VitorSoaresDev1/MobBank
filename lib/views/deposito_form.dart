import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobbank/components/widgets/progress.dart';
import 'package:mobbank/components/widgets/transaction_auth_dialog.dart';
import 'package:mobbank/http/webclients/deposit_webclient.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/deposit.dart';
import 'package:mobbank/models/dialog_models.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/deposit_service.dart';
import 'package:uuid/uuid.dart';

class DepositoForm extends StatefulWidget {
  final List<dynamic> arguments;

  const DepositoForm({
    @required this.arguments,
  });

  @override
  _DepositoFormState createState() => _DepositoFormState();
}

class _DepositoFormState extends State<DepositoForm> {
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
        title: Text('Realizar um deposito'),
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
                    message: 'Enviando...',
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
                    '${_card.numeroConta}',
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
                    child: Text('Depositar'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      showDialog(
                        context: context,
                        builder: (contextDialog) {
                          return TransactionAuthDialog(
                              onConfirm: (String password) {
                            final depositCreated = Deposit(
                                _depositId, value, _card, _user, password);
                            _save(_depositService, depositCreated, password,
                                context);
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

  void _save(DepositService _depositService, Deposit depositCreated,
      String password, BuildContext context) async {
    setState(() {
      _sending = true;
    });

    final Deposit deposit =
        await _send(_depositService, depositCreated, password, context);

    _showSuccessfulMessage(deposit, context);
  }

  Future _showSuccessfulMessage(Deposit deposit, BuildContext context) async {
    if (deposit != null) {
      await showDialog(
              context: context,
              builder: (contextDialog) =>
                  SuccessDialog('O valor foi depositado'))
          .then((value) => Navigator.pop(context));
    }
  }

  Future<Deposit> _send(DepositService _depositService, Deposit depositCreated,
      String password, BuildContext context) async {
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
