import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobbank/locator.dart';
import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/usuario.dart';
import 'package:mobbank/services/bank_card_service.dart';
import 'package:mobbank/services/user_service.dart';
import 'package:mobx/mobx.dart';

part 'card_list_length.g.dart';

class CardListLength = _CardListLength with _$CardListLength;

abstract class _CardListLength with Store {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final BankCardService _bankCardService = locator<BankCardService>();
  final UsersService _usersService = locator<UsersService>();

  @observable
  int count = 0;
  @observable
  int roll = 0;
  @observable
  Usuario user = Usuario();

  @action
  Future<void> setCount() async {
    FirebaseUser fireUser = await _firebaseAuth.currentUser();
    user = await _usersService.getUsuario(fireUser.email);
    await _bankCardService.saveCard(user);
    List<BankCard> cardList = await _bankCardService.getUserCards(user.getId());
    count = cardList.length;
    roll++;
  }

  @action
  void resetRoll() {
    roll = 0;
  }

  @computed
  int get rolling => roll;
}
