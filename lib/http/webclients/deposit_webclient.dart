import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobbank/constants/webclient_urls.dart';
import 'package:mobbank/http/webclient.dart';
import 'package:mobbank/models/deposit.dart';

class DepositWebClient {
  Future<List<Deposit>> findAllByAccountId(int id) async {
    final Response response = await client.get('$DEPOSITS_URL/$id');

    final List<dynamic> decodedJson = jsonDecode(response.body);
    List<dynamic> dynamicList =
        decodedJson.map((dynamic json) => Deposit.fromMap(json)).toList();
    List<Deposit> _depositList = dynamicList.cast<Deposit>();
    return _depositList;
  }

  Future<Deposit> save(Deposit deposit) async {
    final String depositJson = deposit.toJson();
    final Response response = await client.post(DEPOSITS_URL,
        headers: {
          'Content-type': 'application/json',
        },
        body: depositJson);

    if (response.statusCode == 201) {
      return Deposit.fromJson(response.body);
    }

    throw new HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Houve um erro ao realizar a transação',
    401: 'Autenticação Falhou',
    409: 'Transação já existente'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
