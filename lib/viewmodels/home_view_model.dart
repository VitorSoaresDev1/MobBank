import 'package:mobbank/http/webclients/bank_card_webclient.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/deposit.dart';

import 'package:mobbank/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final BankCardWebClient _bankCardClient = locator<BankCardWebClient>();

  Future<BankCard> updateAccountView(int cardId, int id) async {
    List<BankCard> userCards = await _bankCardClient.findAll(id);
    BankCard userCard = userCards[userCards.indexWhere((e) => e.id == cardId)];
    return userCard;
  }

  List<Deposit> filterDeposit(List<Deposit> transactions) =>
      transactions.where((transaction) => transaction.tipo == 1).toList();

  List<Deposit> filterPayment(List<Deposit> transactions) =>
      transactions.where((transaction) => transaction.tipo == 2).toList();

  List<Deposit> filterTransfers(List<Deposit> transactions) =>
      transactions.where((transaction) => transaction.tipo == 3).toList();

  List<Deposit> getAllIncome(List<Deposit> deposits, List<Deposit> incomes) =>
      [...deposits, ...incomes];

  List<Deposit> getAllOutgoings(List<Deposit> transactions) =>
      transactions.where((transaction) => transaction.tipo != 1).toList();

  double totalIncome(List<Deposit> income) => income
      .map((e) => e.value)
      .toList()
      .reduce((value, element) => value + element);

  double totalOutgoings(List<Deposit> outgoings) => outgoings
      .map((e) => e.value)
      .toList()
      .reduce((value, element) => value + element);
}
