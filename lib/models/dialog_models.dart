import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String cancelTitle;

  DialogRequest(
      {@required this.title,
      @required this.description,
      @required this.buttonTitle,
      this.cancelTitle});
}

class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;
  final TextEditingController controller;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
    this.controller,
  });
}

class ResponseDialog extends StatelessWidget {
  final String title;
  final String message;
  final String message2;
  final String buttonText;
  final IconData icon;
  final Color colorIcon;

  ResponseDialog({
    this.title = "",
    this.message = "",
    this.message2 = "",
    this.icon,
    this.buttonText = 'Ok',
    this.colorIcon = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        child: Text(title),
        visible: title.isNotEmpty,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Icon(
                icon,
                size: 64,
                color: colorIcon,
              ),
            ),
            visible: icon != null,
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            visible: message.isNotEmpty,
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                message2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ),
            visible: message2.isNotEmpty,
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(buttonText),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  SuccessDialog(
    this.message, {
    this.title = 'Sucesso',
    this.icon = Icons.done,
  });

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: icon,
      colorIcon: Colors.green,
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;
  final String message2;
  final IconData icon;

  FailureDialog(
    this.message, {
    this.title = 'Falha',
    this.message2 = "",
    this.icon = Icons.warning,
  });

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      message2: message2,
      icon: icon,
      colorIcon: Colors.red,
    );
  }
}

const Key passwordAuthDialogTextFieldPassword =
    Key('passwordAuthDialogTextFieldPassword');

class PasswordAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  PasswordAuthDialog({
    @required this.onConfirm,
  });

  @override
  _PasswordAuthDialogState createState() => _PasswordAuthDialogState();
}

class _PasswordAuthDialogState extends State<PasswordAuthDialog> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Resetar Senha'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Insira um e-mail válido.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                key: passwordAuthDialogTextFieldPassword,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                textAlign: TextAlign.center,
                decoration: InputDecoration(border: UnderlineInputBorder()),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Confirm'),
          onPressed: () async {
            try {
              var result = await widget.onConfirm(_emailController.text);
              if (result != 'Falhou') {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (contextDialog) =>
                        SuccessDialog('E-mail enviado com sucesso.'));
              } else {
                showDialog(
                    context: context,
                    builder: (contextDialog) => FailureDialog(
                          'Falha ao enviar.',
                          message2:
                              '- Verifique se o e-mail é válido. \n - Verifique sua conexão com a internet.',
                        ));
              }
            } catch (e) {
              print('erro');
            }
          },
        ),
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
