import 'package:flutter/material.dart';
import 'package:mobbank/animation/fade_animation.dart';
import 'package:mobbank/components/widgets/feature_item.dart';
import 'package:mobbank/components/widgets/page_view_card_1.dart';
import 'package:mobbank/components/widgets/page_view_card_2.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/navigation_service.dart';

class HomeView extends StatefulWidget {
  final List<dynamic> arguments;

  HomeView({
    @required this.arguments,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NavigationService _navigationService = locator<NavigationService>();

  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BankCard _account = widget.arguments[0];
    Usuario _user = widget.arguments[1];
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Positioned(
                            top: 40,
                            left: 50,
                            child: Center(
                              child: Text(
                                "Mob Bank",
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    letterSpacing: 12,
                                    fontSize: 38,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 250,
                width: 330,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Saldo(account: _account, user: _user),
                    IncomeReport(account: _account, user: _user),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 100,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    FeatureItem(
                      'Depositar',
                      Icons.monetization_on,
                      onClick: () => _navigationService.navigateTo(
                          DepositViewRoute,
                          arguments: [_user, _account]),
                    ),
                    FeatureItem(
                      'Pagar',
                      Icons.monetization_on,
                      onClick: () => print('Pagamentos'),
                    ),
                    FeatureItem(
                      'Transferir',
                      Icons.monetization_on,
                      onClick: () => print('transfer'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 100,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    FeatureItem(
                      'Extrato de Depositos',
                      Icons.description,
                      onClick: () => print('Extrato de Depositos'),
                    ),
                    FeatureItem(
                      'Extrato de Pagamentos',
                      Icons.description,
                      onClick: () => print('Extrato de pagamentos'),
                    ),
                    FeatureItem(
                      'Extrato de Transferências',
                      Icons.description,
                      onClick: () => print('Extrato de Transferências'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
