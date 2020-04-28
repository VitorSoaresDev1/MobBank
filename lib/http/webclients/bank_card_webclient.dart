import 'dart:convert';

import 'package:http/http.dart';

import '../../constants/webclient_urls.dart';
import '../../models/bank_card.dart';
import '../webclient.dart';

class BankCardWebClient {
  Future<List<BankCard>> findAll(userId) async {
    final Response response = await client.get('$BANKCARDS_URL/$userId');
    if (response.statusCode == 200) {
      print("buscando");
      final List<dynamic> decodedJson = jsonDecode(response.body);
      List<dynamic> dynamicList =
          decodedJson.map((dynamic json) => BankCard.fromMap(json)).toList();
      List<BankCard> cardsList = dynamicList.cast<BankCard>();
      return cardsList;
    } else {
      return new List();
    }
  }

  Future<BankCard> save(BankCard card) async {
    final String cardJson = card.toJson();

    final Response response = await client.post(BANKCARDS_URL,
        headers: {
          'Content-type': 'application/json',
        },
        body: cardJson);

    if (response.statusCode == 201) {
      return BankCard.fromJson(response.body);
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
