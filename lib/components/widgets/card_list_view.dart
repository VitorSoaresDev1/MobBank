import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/bank_card_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/services/user_service.dart';
import 'package:mobbank/store/card_list_length.dart';

class CardsListWheel extends StatefulWidget {
  final Usuario user;

  const CardsListWheel({Key key, this.user}) : super(key: key);

  @override
  _CardsListWheelState createState() => _CardsListWheelState();
}

class _CardsListWheelState extends State<CardsListWheel> {
  final BankCardService _bankCardService = locator<BankCardService>();
  final CardListLength listLength = CardListLength();
  final ScrollController _scrollController = ScrollController();
  final NavigationService _navigationService = locator<NavigationService>();
  final UsersService _usersService = locator<UsersService>();

  @override
  Widget build(BuildContext context) {
    String nameWithInitials = '';
    List<String> initials = widget.user.getNome().split(' ');
    for (var i = 0; i < initials.length; i++) {
      if (i == 0 || i == initials.length - 1) {
        nameWithInitials += '${initials[i]} ';
      } else {
        nameWithInitials += '${initials[i].substring(0, 1)}. ';
      }
    }
    return FutureBuilder(
      future: _bankCardService.getUserCards(widget.user.getId()),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          bool hasCards = snapshot.data.length > 0;
          List<BankCard> listCards = snapshot.data;
          Comparator<BankCard> idComparator = (a, b) => a.id.compareTo(b.id);
          listCards.sort(idComparator);
          return Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: !hasCards
                      ? Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () async {
                                  listLength.setCount();
                                  setState(() {});
                                },
                                icon: Icon(Icons.add_circle_outline),
                                iconSize: 180,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Você ainda não tem cartões cadastrados.'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Clique no'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      size: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(' para cadastrar um cartão.')
                                ],
                              )
                            ],
                          ),
                        )
                      : Observer(
                          builder: (_) {
                            return ListWheelScrollView.useDelegate(
                              controller: _scrollController,
                              diameterRatio: 30,
                              offAxisFraction: 10,
                              squeeze: 1,
                              itemExtent: 360,
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: listCards.length,
                                builder: (BuildContext context, int index) {
                                  if (listCards.length > 1) {
                                    // _scrollController.animateTo(
                                    //     (360 *
                                    //             (listLength.count > 0
                                    //                 ? listLength.count
                                    //                 : 1))
                                    //         .toDouble(),
                                    //     duration: Duration(milliseconds: 1000),
                                    //     curve: Curves.ease);
                                    // listLength.resetRoll();
                                  }
                                  String dateYear = listCards[index]
                                      .dataExpiracao
                                      .year
                                      .toString()
                                      .substring(2, 4);
                                  String dateMonth = listCards[index]
                                              .dataExpiracao
                                              .month >
                                          9
                                      ? listCards[index].dataExpiracao.month
                                      : '0${listCards[index].dataExpiracao.month}';
                                  String expirationDate =
                                      '$dateMonth/$dateYear';

                                  String accountNumber =
                                      '${listCards[index].numeroConta.substring(0, 3)} ${listCards[index].numeroConta.substring(3, 6)} ${listCards[index].numeroConta.substring(6, 9)}';
                                  return Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          height: 300,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                new BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 3.0,
                                                ),
                                                new BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 10.0,
                                                  offset: Offset(-30.0, -15.0),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: LinearGradient(colors: [
                                                Color.fromRGBO(
                                                    20 * (index),
                                                    40 * (index),
                                                    60 * (index - 1),
                                                    1),
                                                Color.fromRGBO(
                                                    15 * (index - 1),
                                                    10 * (index - 1),
                                                    25 * (index - 1),
                                                    1),
                                              ])),
                                        ),
                                      ),
                                      Positioned(
                                        right: 210,
                                        bottom: 50,
                                        child: Container(
                                          height: 60,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(),
                                            gradient: RadialGradient(
                                              colors: [
                                                Color.fromRGBO(
                                                    248, 231, 199, 1),
                                                Color.fromRGBO(
                                                    207, 186, 127, 1),
                                              ],
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.blur_on,
                                            size: 45,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25,
                                        left: 160,
                                        child: Container(
                                          transform: Matrix4.rotationZ(-1.55),
                                          child: Text(
                                            "$accountNumber",
                                            style: TextStyle(
                                              fontSize: 20,
                                              wordSpacing: 5,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 0.5,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                Shadow(
                                                  offset: Offset(0.2, 0.2),
                                                  blurRadius: 0.5,
                                                  color: Color.fromARGB(
                                                      50, 50, 50, 150),
                                                ),
                                              ],
                                              color: Color.fromRGBO(
                                                  98, 103, 107, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 147,
                                        left: 195,
                                        child: Container(
                                          transform: Matrix4.rotationZ(-1.55),
                                          child: Text(
                                            "$expirationDate",
                                            style: TextStyle(
                                              fontSize: 15,
                                              wordSpacing: 5,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 1.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ],
                                              color: Color.fromRGBO(
                                                  98, 103, 107, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25,
                                        left: 220,
                                        child: Container(
                                          transform: Matrix4.rotationZ(-1.55),
                                          child: Text(
                                            "${nameWithInitials.toUpperCase()}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              wordSpacing: 5,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 1.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ],
                                              color: Color.fromRGBO(
                                                  98, 103, 107, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 257,
                                        left: 240,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                246, 29, 49, 0.8),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 280,
                                        left: 240,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                252, 167, 0, 0.7),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 242,
                                        left: 279,
                                        child: Container(
                                          transform: Matrix4.rotationZ(-1.55),
                                          child: Text(
                                            "mastercard",
                                            style: TextStyle(
                                              fontSize: 12,
                                              wordSpacing: 5,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 1.0,
                                                  color: Color.fromARGB(
                                                      130, 0, 0, 0),
                                                ),
                                              ],
                                              color: Color.fromRGBO(
                                                  180, 180, 180, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ),
              FloatingActionButton(
                elevation: 6.0,
                onPressed: () async {
                  listLength.setCount().whenComplete(() => setState(() {
                        _navigationService.replaceWith(DashBoardRoute,
                            arguments: [listLength.user]);
                      }));
                },
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.add_circle_outline,
                  size: 64,
                  color: Colors.grey,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
