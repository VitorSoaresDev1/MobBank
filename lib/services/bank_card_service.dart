import 'dart:math';

import 'package:mobbank/http/webclients/bank_card_webclient.dart';

import '../models/bank_card.dart';
import '../models/usuario.dart';

import '../locator.dart';

class BankCardService {
  final BankCardWebClient _bankCardClient = locator<BankCardWebClient>();

  Future<List<BankCard>> getUserCards(int id) async {
    List<BankCard> userCards = await _bankCardClient.findAll(id);
    return userCards;
  }

  Future<double> totalValue(int id) async {
    List<BankCard> userCards = await _bankCardClient.findAll(id);
    List<double> amount = userCards.map((card) => card.saldo).toList();
    return amount.reduce((value, element) => value + element);
  }

  Future<void> saveCard(Usuario user) async {
    var rng = new Random();
    var l = new List.generate(9, (_) => rng.nextInt(9));
    String number = '';
    for (var i = 0; i < l.length; i++) {
      number = '$number${l[i]}';
    }
    BankCard card = new BankCard(
      id: 0,
      numeroConta: number,
      dataCriacao: DateTime.now(),
      dataExpiracao: DateTime.now(),
      userId: user,
      saldo: 0.00,
    );

    await _bankCardClient.save(card);
  }
}
