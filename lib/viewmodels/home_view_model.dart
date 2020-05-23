import 'package:mobbank/http/webclients/bank_card_webclient.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';

import 'package:mobbank/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final BankCardWebClient _bankCardClient = locator<BankCardWebClient>();

  Future<BankCard> updateAccountView(int cardId, int id) async {
    List<BankCard> userCards = await _bankCardClient.findAll(id);
    BankCard userCard = userCards[userCards.indexWhere((e) => e.id == cardId)];
    return userCard;
  }
}
