import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceWith(String routeName, {dynamic arguments}) {
    if (_navigationKey.currentState.canPop())
      _navigationKey.currentState
          .popUntil((route) => !route.navigator.canPop());
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}
