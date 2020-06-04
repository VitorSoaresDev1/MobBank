import 'package:flutter/material.dart';
import 'package:mobbank/animation/fade_animation.dart';
import 'package:mobbank/components/widgets/draggable_report.dart';
import 'package:mobbank/components/widgets/drawer.dart';
import 'package:mobbank/components/widgets/feature_item.dart';
import 'package:mobbank/components/widgets/page_view_card_1.dart';
import 'package:mobbank/components/widgets/page_view_card_2.dart';
import 'package:mobbank/components/widgets/progress.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/deposit.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/bank_card_service.dart';
import 'package:mobbank/services/deposit_service.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'package:mobbank/viewmodels/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

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
  List<Deposit> transactions = new List<Deposit>();
  String tipo;
  int code;
  bool depositVisibility = false;
  Color iconColor;
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
    BankCard _card = widget.arguments[0];
    Usuario _user = widget.arguments[1];
    final BankCardService _bankCardService = locator<BankCardService>();
    final DepositService _depositService = locator<DepositService>();

    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      builder: (context, model, child) {
        return FutureBuilder(
          future: Future.wait([
            model.updateAccountView(_card.id, _user.id),
            _bankCardService.totalValue(_user.id),
            _depositService.getAccountDeposits(_card.id),
            _depositService.getReceivedDeposits(_card.numeroConta),
          ]),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(child: Scaffold(body: Progress()));
            BankCard _account = snapshot.data[0];
            List<Deposit> _deposits = snapshot.data[2];
            List<Deposit> _incomes = snapshot.data[3];
            return new Scaffold(
              backgroundColor: Color(0xff21254A),
              endDrawer: AppDrawer(profile: _user, ammount: snapshot.data[1]),
              body: SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
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
                                        Positioned(
                                          top: 100,
                                          right: -15,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                shape: BoxShape.circle),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.fast_rewind)
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(54, 54, 54, 1)),
                              height: 250,
                              width: 350,
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
                                  IncomeReport(
                                    account: _account,
                                    user: _user,
                                    deposits: _deposits,
                                    incomes: _incomes,
                                    incomeClick: () => setState(() {
                                      depositVisibility = !depositVisibility;
                                      transactions = model.getAllIncome(
                                          model.filterDeposit(_deposits),
                                          _incomes);
                                      tipo = 'Recebimentos';
                                      code = 4;
                                    }),
                                    outgoingClick: () => setState(() {
                                      depositVisibility = !depositVisibility;
                                      transactions =
                                          model.getAllOutgoings(_deposits);
                                      tipo = 'Saídas';
                                      code = 4;
                                    }),
                                  ),
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
                                    onClick: () => _navigationService
                                        .navigateTo(DepositViewRoute,
                                            arguments: [_user, _account]),
                                  ),
                                  FeatureItem(
                                    'Pagar',
                                    Icons.monetization_on,
                                    onClick: () => _navigationService
                                        .navigateTo(PaymentViewRoute,
                                            arguments: [_user, _account]),
                                  ),
                                  FeatureItem(
                                    'Transferir',
                                    Icons.monetization_on,
                                    onClick: () => _navigationService
                                        .navigateTo(ContactsListRoute,
                                            arguments: [_user, _account]),
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
                                    onClick: () => setState(() {
                                      depositVisibility = !depositVisibility;
                                      transactions =
                                          model.filterDeposit(_deposits);
                                      tipo = 'Depósitos';
                                      code = 1;
                                      iconColor = Colors.green;
                                    }),
                                  ),
                                  FeatureItem(
                                    'Extrato de Pagamentos',
                                    Icons.description,
                                    onClick: () => setState(() {
                                      depositVisibility = !depositVisibility;
                                      transactions =
                                          model.filterPayment(_deposits);
                                      tipo = 'Pagamentos';
                                      code = 2;
                                      iconColor = Colors.red;
                                    }),
                                  ),
                                  FeatureItem(
                                    'Extrato de Transferências',
                                    Icons.description,
                                    onClick: () => setState(() {
                                      depositVisibility = !depositVisibility;
                                      transactions =
                                          model.filterTransfers(_deposits);
                                      tipo = 'Transferências';
                                      code = 3;
                                      iconColor = Colors.red;
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: depositVisibility,
                        child: DraggableReport(
                          onDoubleClick: () => setState(
                              () => depositVisibility = !depositVisibility),
                          code: code,
                          profile: _user,
                          transactions: transactions,
                          tipo: tipo,
                          iconColor: iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
