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

  Future<void> saveCard(Usuario user) async {
    var rng = new Random();
    var l = new List.generate(9, (_) => rng.nextInt(9));
    String number = '';
    for (var i = 0; i < l.length; i++) {
      number = '$number${l[i]}';
    }
    //Usuario user = await _usuarioWebClient.findOneById(id);
    BankCard card = new BankCard(
      id: 0,
      numeroConta: number,
      ownerId: user,
      saldo: 0.00,
    );

    await _bankCardClient.save(card);
  }
}
