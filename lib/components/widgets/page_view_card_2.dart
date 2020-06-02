import 'package:flutter/material.dart';
import 'package:mobbank/components/helper/currency_helper.dart';
import 'package:mobbank/components/widgets/circle_avatar.dart';

import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/deposit.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/viewmodels/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class IncomeReport extends StatefulWidget {
  final Usuario user;
  final BankCard account;
  final List<Deposit> deposits;
  final List<Deposit> incomes;
  final Function incomeClick;
  final Function outgoingClick;
  const IncomeReport({
    @required this.user,
    @required this.account,
    @required this.deposits,
    @required this.incomes,
    @required this.incomeClick,
    @required this.outgoingClick,
  });

  @override
  _IncomeReportState createState() => _IncomeReportState();
}

class _IncomeReportState extends State<IncomeReport> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        builder: (context, model, child) {
          double totalIncome = model.totalIncome(model.getAllIncome(
              model.filterDeposit(widget.deposits), widget.incomes));
          double totalOutgoing =
              model.totalOutgoings(model.getAllOutgoings(widget.deposits));
          return Container(
            margin: EdgeInsets.only(left: 2, right: 0),
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
                    'Fluxo Total: ',
                  ),
                  Card(
                    child: ListTile(
                      onTap: () => widget.incomeClick(),
                      leading: Icon(
                        Icons.arrow_downward,
                        color: Colors.green[700],
                      ),
                      title: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${CurrencyHelper.currency(totalIncome)}',
                          style: TextStyle(color: Colors.green[700]),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () => widget.outgoingClick(),
                      leading: Icon(
                        Icons.arrow_upward,
                        color: Colors.red[700],
                      ),
                      title: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${CurrencyHelper.currency(totalOutgoing)}',
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
