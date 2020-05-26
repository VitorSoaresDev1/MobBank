import 'package:flutter/material.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/navigation_service.dart';

import '../../locator.dart';

class AppDrawer extends StatelessWidget {
  final Usuario profile;
  final NavigationService _navigationService = locator<NavigationService>();
  final double ammount;
  AppDrawer({@required this.profile, this.ammount});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:
                Text('${this.profile.firstName} ${this.profile.lastName}'),
            accountEmail: Text(this.profile.email),
            currentAccountPicture: CircleAvatar(
              child: Text(this.profile.initials.toUpperCase(),
                  style: TextStyle(fontSize: 38.0)),
              backgroundColor: Colors.pinkAccent,
            ),
          ),
          ExpansionTile(
            leading: Icon(Icons.attach_money),
            title: Text("Saldo total"),
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.local_atm),
                  title: Text("R\$ $ammount"),
                  onTap: () => null),
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Mudar de conta"),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => _navigationService
                .replaceWith(DashBoardRoute, arguments: [this.profile]),
          ),
        ],
      ),
    );
  }
}
