import 'package:flutter/material.dart';
import 'package:mobbank/components/widgets/circle_avatar.dart';

import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/usuario.dart';

class IncomeReport extends StatefulWidget {
  final Usuario user;
  final BankCard account;
  const IncomeReport({
    @required this.user,
    @required this.account,
  });

  @override
  _IncomeReportState createState() => _IncomeReportState();
}

class _IncomeReportState extends State<IncomeReport> {
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
            Text(
              'Fluxo no mês: ',
            ),
            Card(
              child: ListTile(
                onTap: () => print(
                    'abrir extrato de depositos e transferências recebidas'),
                leading: Icon(
                  Icons.arrow_downward,
                  color: Colors.green[700],
                ),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${widget.account.currency}',
                    style: TextStyle(color: Colors.green[700]),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () => print(
                    'abrir extrato de pagamentos e transferências efetuadas'),
                leading: Icon(
                  Icons.arrow_upward,
                  color: Colors.red[700],
                ),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${widget.account.currency}',
                    style: TextStyle(color: Colors.red[700]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
