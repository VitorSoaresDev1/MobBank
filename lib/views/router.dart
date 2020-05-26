import 'package:flutter/material.dart';
import 'package:mobbank/views/dashboard.dart';
import 'package:mobbank/views/deposito_form.dart';
import 'package:mobbank/views/pagamento_form.dart';
import 'package:mobbank/views/sign_up.dart';
import 'package:mobbank/views/home_view.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/views/transferencia_form.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashBoardRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Dashboard(arguments: settings.arguments),
      );
    case SignUpRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUp(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(arguments: settings.arguments),
      );
    case DepositViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DepositoForm(arguments: settings.arguments),
      );
    case PaymentViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PagamentoForm(arguments: settings.arguments),
      );
    case TransferViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: TransferenciaForm(arguments: settings.arguments),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
