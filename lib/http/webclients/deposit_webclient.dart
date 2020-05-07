import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobbank/constants/webclient_urls.dart';
import 'package:mobbank/http/webclient.dart';
import 'package:mobbank/models/deposit.dart';

class DepositWebClient {
  Future<List<Deposit>> findAllByUserId(int id) async {
    final Response response = await client.get('$DEPOSITS_URL/$id');
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Deposit.fromJson(json)).toList();
  }

  Future<Deposit> save(Deposit deposit) async {
    final String depositJson = deposit.toJson();
    depositJson;
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
    400: 'There was an error submiting the transaction',
    401: 'Authentication Failed',
    409: 'Transaction already exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
