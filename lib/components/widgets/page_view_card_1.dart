import 'package:flutter/material.dart';
import 'package:mobbank/components/widgets/circle_avatar.dart';

import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/usuario.dart';

class Saldo extends StatefulWidget {
  final Usuario user;
  final BankCard account;
  const Saldo({
    @required this.user,
    @required this.account,
  });

  @override
  _SaldoState createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 150,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CustomCircleAvatar(
                      text: '${widget.user.initials.toUpperCase()}'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Olá, ${widget.user.firstName}',
                      ),
                    ),
                    Text(
                      'Nº da conta: ${widget.account.spacedAccountNumber}',
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 79,
                  width: 360,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text('Saldo:'),
                        ),
                      ),
                      SizedBox(width: 180),
                    ],
                  ),
                ),
                Container(
                  height: 79,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${widget.account.currency}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
