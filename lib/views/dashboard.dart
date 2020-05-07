import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobbank/animation/fade_animation.dart';
import 'package:mobbank/components/styles/shared_styles.dart';
import 'package:mobbank/components/widgets/busy_button.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/services/bank_card_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/store/card_list_length.dart';
import 'package:mobbank/viewmodels/dashboard_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
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
    final NavigationService _navigationService = locator<NavigationService>();
    final CardListLength listLength = CardListLength();
    List<BankCard> listCards = new List();
    bool busy = false;

    listLength.setCount(_user.id);

    return ViewModelProvider<DashboardViewModel>.withConsumer(
      viewModel: DashboardViewModel(),
      builder: (context, model, child) => new Scaffold(
        backgroundColor: Color(0xff21254A),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  overflow: Overflow.visible,
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
                                    image: AssetImage(
                                        "assets/images/purple_wave.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    callCardListView(
                      _bankCardService,
                      _user,
                      listCards,
                      listLength,
                      _navigationService,
                    ),
                    Positioned(
                      top: 0,
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.999,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromRGBO(130, 57, 199, 1),
                          Color.fromRGBO(112, 60, 207, 1)
                        ])),
                        child: Card(
                          margin: EdgeInsets.only(top: 0),
                          color: Colors.transparent,
                          elevation: 15,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Escolha uma conta para acessar:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 159,
                      bottom: -21,
                      child: Observer(
                        builder: (_) => Container(
                          child: Row(
                            children: <Widget>[
                              FadeAnimation(
                                1,
                                BusyButton(
                                  height: 16,
                                  width: 17,
                                  shape: 30,
                                  isIcon: true,
                                  busy: true,
                                  icon: Icons.add,
                                  buttonTextStyle: buttonFloatTitleTextStyle,
                                  onPressed: null,
                                  color: Color.fromRGBO(97, 97, 97, 0.2),
                                  title: "+",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(128, 58, 199, 0.2),
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 40,
          ),
        ),
        floatingActionButton: Observer(
          builder: (_) => FloatingActionButton(
            elevation: 0,
            onPressed: listLength.count >= 5
                ? null
                : () async {
                    busy = true;
                    model.createCard(listLength: listLength);
                  },
            backgroundColor: busy
                ? Colors.transparent
                : listLength.count >= 5
                    ? Color.fromRGBO(97, 97, 97, 1)
                    : Color.fromRGBO(71, 12, 130, 1),
            child: Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  callCardListView(
      BankCardService _bankCardService,
      Usuario _user,
      List<BankCard> listCards,
      CardListLength listLength,
      NavigationService _navigationService) {
    return FutureBuilder(
      future: _bankCardService.getUserCards(_user.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          bool hasCards = snapshot.data.length > 0;
          listCards = snapshot.data;
          Comparator<BankCard> idComparator = (a, b) => a.id.compareTo(b.id);
          listCards.sort(idComparator);
          BankCard currentCard =
              listCards.length > 0 ? listCards[0] : new BankCard();
          return Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.905,
                  width: MediaQuery.of(context).size.width,
                  child: !hasCards
                      ? Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: null,
                                icon: Icon(Icons.photo_size_select_small),
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
                                      Icons.add,
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
                            return GestureDetector(
                              onTap: () => _navigationService.navigateTo(
                                  HomeViewRoute,
                                  arguments: [currentCard, _user]),
                              child: InkWell(
                                child: Stack(
                                  children: <Widget>[
                                    ListWheelScrollView.useDelegate(
                                      onSelectedItemChanged: (index) =>
                                          currentCard = listCards[index],
                                      diameterRatio: 30,
                                      offAxisFraction: 10,
                                      squeeze: 0.9,
                                      itemExtent: 360,
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        childCount: listCards.length,
                                        builder:
                                            (BuildContext context, int index) {
                                          String dateYear = listCards[index]
                                              .dataExpiracao
                                              .year
                                              .toString()
                                              .substring(2, 4);
                                          String dateMonth = listCards[index]
                                                      .dataExpiracao
                                                      .month >
                                                  9
                                              ? listCards[index]
                                                  .dataExpiracao
                                                  .month
                                              : '0${listCards[index].dataExpiracao.month}';
                                          String expirationDate =
                                              '$dateMonth/$dateYear';
                                          return Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                  child: Container(
                                                    height: 300,
                                                    width:
                                                        MediaQuery.of(context)
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
                                                            offset: Offset(
                                                                -30.0, -15.0),
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Color.fromRGBO(
                                                                  20 * (index),
                                                                  40 * (index),
                                                                  60 *
                                                                      (index -
                                                                          1),
                                                                  1),
                                                              Color.fromRGBO(
                                                                  15 *
                                                                      (index -
                                                                          1),
                                                                  10 *
                                                                      (index -
                                                                          1),
                                                                  25 *
                                                                      (index -
                                                                          1),
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                    transform:
                                                        Matrix4.rotationZ(
                                                            -1.55),
                                                    child: Text(
                                                      listCards[index]
                                                          .spacedAccountNumber,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        wordSpacing: 5,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                            blurRadius: 0.5,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                          ),
                                                          Shadow(
                                                            offset: Offset(
                                                                0.2, 0.2),
                                                            blurRadius: 0.5,
                                                            color:
                                                                Color.fromARGB(
                                                                    50,
                                                                    50,
                                                                    50,
                                                                    150),
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
                                                    transform:
                                                        Matrix4.rotationZ(
                                                            -1.55),
                                                    child: Text(
                                                      "$expirationDate",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        wordSpacing: 5,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                            blurRadius: 1.0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
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
                                                    transform:
                                                        Matrix4.rotationZ(
                                                            -1.55),
                                                    child: Text(
                                                      "${_user.cardInitials.toUpperCase()}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        wordSpacing: 5,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                            blurRadius: 1.0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
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
                                                    transform:
                                                        Matrix4.rotationZ(
                                                            -1.55),
                                                    child: Text(
                                                      "mastercard",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        wordSpacing: 5,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                1.0, 1.0),
                                                            blurRadius: 1.0,
                                                            color:
                                                                Color.fromARGB(
                                                                    130,
                                                                    0,
                                                                    0,
                                                                    0),
                                                          ),
                                                        ],
                                                        color: Color.fromRGBO(
                                                            180, 180, 180, 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      left: 50,
                                      top: 163,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 5,
                                            width: 35,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 180,
                                          ),
                                          Container(
                                            height: 5,
                                            width: 35,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 53,
                                      bottom: 162,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 5,
                                            width: 35,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 180,
                                          ),
                                          Container(
                                            height: 5,
                                            width: 35,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 50,
                                      top: 163,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 35,
                                            width: 5,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 245,
                                          ),
                                          Container(
                                            height: 35,
                                            width: 5,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 52,
                                      bottom: 162,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 35,
                                            width: 5,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 245,
                                          ),
                                          Container(
                                            height: 35,
                                            width: 5,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
