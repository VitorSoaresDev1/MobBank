import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/views/sign_in.dart';
import 'package:mobbank/services/dialog_service.dart';
import 'package:mobbank/managers/dialog_manager.dart';
import 'package:mobbank/services/navigation_service.dart';
import 'views/router.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mob Bank',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData.dark(),
      home: SignIn(),
      onGenerateRoute: generateRoute,
    );
  }
}
