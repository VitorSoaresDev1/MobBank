import 'dart:convert';

import 'package:mobbank/models/usuario.dart';

class BankCard {
  final int id;
  final DateTime dataCriacao;
  final DateTime dataExpiracao;
  final String numeroConta;
  final Usuario ownerId;
  final double saldo;
  BankCard({
    this.id,
    this.dataCriacao,
    this.dataExpiracao,
    this.numeroConta,
    this.ownerId,
    this.saldo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataCriacao': dataCriacao?.millisecondsSinceEpoch,
      'dataExpiracao': dataExpiracao?.millisecondsSinceEpoch,
      'numeroConta': numeroConta,
      'ownerId': ownerId?.toMap(),
      'saldo': saldo,
    };
  }

  static BankCard fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BankCard(
      id: map['id'],
      dataCriacao: DateTime.parse(map['dataCriacao']),
      dataExpiracao: DateTime.parse(map['dataExpiracao']),
      numeroConta: map['numeroConta'],
      ownerId: Usuario.fromMap(map['ownerId']),
      saldo: map['saldo'],
    );
  }

  String toJson() => json.encode(toMap());

  static BankCard fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BankCard &&
        o.id == id &&
        o.dataCriacao == dataCriacao &&
        o.dataExpiracao == dataExpiracao &&
        o.numeroConta == numeroConta &&
        o.ownerId == ownerId &&
        o.saldo == saldo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataCriacao.hashCode ^
        dataExpiracao.hashCode ^
        numeroConta.hashCode ^
        ownerId.hashCode ^
        saldo.hashCode;
  }

  @override
  String toString() {
    return 'BankCard(id: $id, dataCriacao: $dataCriacao, dataExpiracao: $dataExpiracao, numeroConta: $numeroConta, ownerId: $ownerId, saldo: $saldo)';
  }
}
