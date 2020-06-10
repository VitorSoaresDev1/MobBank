import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobbank/components/helper/currency_helper.dart';
import 'package:mobbank/models/deposit.dart';
import 'package:mobbank/models/usuario.dart';

class DraggableReport extends StatelessWidget {
  final Function onDoubleClick;
  final Usuario profile;
  final List<Deposit> transactions;
  final String tipo;
  final Color iconColor;
  final int code;
  DraggableReport({
    Key key,
    @required this.onDoubleClick,
    @required this.profile,
    @required this.transactions,
    @required this.tipo,
    @required this.iconColor,
    @required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return DraggableScrollableSheet(
      initialChildSize: 0.09,
      minChildSize: 0.09,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          child: ListView(
            controller: scrollController,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onDoubleTap: () => onDoubleClick(),
                  child: ListTile(
                    title: Text(
                      'Relatório de $tipo',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: new DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Material(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: transactions.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: transactions.length,
                                  controller: ScrollController(),
                                  itemExtent: code != 3 ? 81 : 96,
                                  itemBuilder: (buildContext, index) {
                                    Color color;
                                    switch (transactions[index].tipo) {
                                      case 1:
                                        color = Colors.green;
                                        break;
                                      case 2:
                                        color = Colors.red;
                                        break;
                                      case 3:
                                        color = Colors.blue;
                                        break;
                                      default:
                                    }
                                    return Column(
                                      children: <Widget>[
                                        Card(
                                          color: Colors.grey[200],
                                          elevation: 0,
                                          child: ListTile(
                                            onTap: () => null,
                                            leading: Icon(
                                              Icons.attach_money,
                                              color:
                                                  code > 3 ? color : iconColor,
                                            ),
                                            title: Text(
                                              'Data: ${DateFormat(DateFormat.YEAR_NUM_MONTH_DAY, 'pt-Br').format(transactions[index].dataRealizacao).toString()} ${DateFormat(DateFormat.HOUR24_MINUTE, 'pt-Br').format(transactions[index].dataRealizacao).toString()}',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              maxLines: 1,
                                            ),
                                            subtitle: code != 3
                                                ? Text(
                                                    'Valor: ${CurrencyHelper.currency(transactions[index].value)}',
                                                    style: TextStyle(
                                                        color: Colors.black))
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                          'Valor: ${transactions[index].value}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          )),
                                                      Text(
                                                          'Transferência para conta: ${transactions[index].transferTo}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                            isThreeLine:
                                                code != 3 ? false : true,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.search,
                                        color: Colors.black87,
                                        size: 40,
                                      ),
                                      Text(
                                        'Nenhum resultado para essa consulta',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        );
      },
    );
  }
}
