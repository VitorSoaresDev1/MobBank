import 'dart:convert';

import 'package:mobbank/models/bank_card.dart';
import 'package:mobbank/models/usuario.dart';

class Deposit {
  final String uuid;
  final double value;
  final BankCard card;
  final Usuario user;
  final String senha;

  Deposit(
    this.uuid,
    this.value,
    this.card,
    this.user,
    this.senha,
  ) : assert(value > 0);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'value': value,
      'card': card?.toMap(),
      'user': user?.toMap(),
      'senha': senha,
    };
  }

  static Deposit fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Deposit(
      map['uuid'],
      map['value'],
      BankCard.fromMap(map['card']),
      Usuario.fromMap(map['user']),
      map['senha'],
    );
  }

  String toJson() => json.encode(toMap());

  static Deposit fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Deposit &&
      o.uuid == uuid &&
      o.value == value &&
      o.card == card &&
      o.user == user &&
      o.senha == senha;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      value.hashCode ^
      card.hashCode ^
      user.hashCode ^
      senha.hashCode;
  }

  @override
  String toString() {
    return 'Deposit(uuid: $uuid, value: $value, card: $card, user: $user, senha: $senha)';
  }
}
