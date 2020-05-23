import 'package:flutter/material.dart';
import 'package:mobbank/models/usuario.dart';

class DraggableReport extends StatelessWidget {
  final Function onDoubleClick;
  final Usuario profile;
  final List<Icon> icons = new List<Icon>();
  DraggableReport({
    Key key,
    @required this.onDoubleClick,
    @required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
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
                      'Relatório de Depositos',
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 15,
                            controller: ScrollController(),
                            itemExtent: 81,
                            itemBuilder: (buildContext, index) {
                              return Column(
                                children: <Widget>[
                                  Card(
                                    color: Colors.grey[200],
                                    elevation: 0,
                                    child: ListTile(
                                      onTap: () => print("Deposit ListTile"),
                                      leading: Icon(
                                        Icons.attach_money,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        'Alerta: Description',
                                        style: TextStyle(color: Colors.black),
                                        maxLines: 1,
                                      ),
                                      subtitle: Text(
                                        'Nível: ',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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
