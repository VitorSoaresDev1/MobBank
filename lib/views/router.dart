import 'package:flutter/material.dart';
import 'package:mobbank/views/dashboard.dart';
import 'package:mobbank/views/sign_up.dart';
import 'package:mobbank/constants/route_names.dart';

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
