import 'package:flutter/material.dart';
import 'package:mobbank/components/widgets/progress.dart';
import 'package:mobbank/constants/route_names.dart';
import 'package:mobbank/database/dao/contact_dao.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/contact.dart';
import 'package:mobbank/services/navigation_service.dart';

class ContactsList extends StatefulWidget {
  final List<dynamic> arguments;

  const ContactsList({
    @required this.arguments,
  });
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    ContactDAO _contactDao = locator<ContactDAO>();
    NavigationService _navigationService = locator<NavigationService>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferir Para'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: FutureBuilder<List<Contact>>(
              initialData: List(),
              future: _contactDao.findAll(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return Progress();
                    break;
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    final List<Contact> contacts = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Contact contact = contacts[index];
                        return ContactItem(
                          contact,
                          onClick: () => _navigationService
                              .navigateTo(TransferViewRoute, arguments: [
                            widget.arguments[0],
                            widget.arguments[1],
                            contact,
                          ]),
                        );
                      },
                      itemCount: contacts.length,
                    );
                    break;
                }
                return Text('Unknown error');
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.55,
                child: RaisedButton(
                  color: Colors.grey[800],
                  onPressed: () => _navigationService
                      .navigateTo(TransferViewRoute, arguments: [
                    widget.arguments[0],
                    widget.arguments[1],
                    Contact(0, null, null),
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Text('Transferir sem adicionar',
                          style: TextStyle(fontSize: 12)),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[600],
        onPressed: () => _navigationService
            .navigateTo(ContactFormRoute)
            .then((value) => setState(() => 1 == 1)),
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  ContactItem(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => this.onClick(),
        title: Text(contact.name, style: TextStyle(fontSize: 24.0)),
        subtitle: Text(contact.accountNumber.toString(),
            style: TextStyle(fontSize: 16.9)),
      ),
    );
  }
}
