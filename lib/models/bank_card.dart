import 'dart:convert';

import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:mobbank/models/usuario.dart';

class BankCard {
  final int id;
  final DateTime dataCriacao;
  final DateTime dataExpiracao;
  final String numeroConta;
  final Usuario userId;
  final double saldo;
  BankCard({
    this.id,
    this.dataCriacao,
    this.dataExpiracao,
    this.numeroConta,
    this.userId,
    this.saldo,
  });

  get spacedAccountNumber =>
      '${numeroConta.substring(0, 3)} . ${numeroConta.substring(3, 6)} . ${numeroConta.substring(6, 9)}';

  get currency {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: this.saldo,
        settings: MoneyFormatterSettings(
            symbol: 'R\$',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 2,
            compactFormatType: CompactFormatType.short));
    String currency = fmf.output.symbolOnLeft;
    return currency;
  }

  BankCard copyWith({
    int id,
    DateTime dataCriacao,
    DateTime dataExpiracao,
    String numeroConta,
    Usuario userId,
    double saldo,
  }) {
    return BankCard(
      id: id ?? this.id,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataExpiracao: dataExpiracao ?? this.dataExpiracao,
      numeroConta: numeroConta ?? this.numeroConta,
      userId: userId ?? this.userId,
      saldo: saldo ?? this.saldo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataCriacao': this.dataCriacao.toString(),
      'dataExpiracao': this.dataExpiracao.toString(),
      'numeroConta': numeroConta,
      'ownerId': userId?.toMap(),
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
      userId: Usuario.fromMap(map['ownerId']),
      saldo: map['saldo'],
    );
  }

  String toJson() => json.encode(toMap());

  static BankCard fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'BankCard(id: $id, dataCriacao: $dataCriacao, dataExpiracao: $dataExpiracao, numeroConta: $numeroConta, userId: $userId, saldo: $saldo)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BankCard &&
        o.id == id &&
        o.dataCriacao == dataCriacao &&
        o.dataExpiracao == dataExpiracao &&
        o.numeroConta == numeroConta &&
        o.userId == userId &&
        o.saldo == saldo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataCriacao.hashCode ^
        dataExpiracao.hashCode ^
        numeroConta.hashCode ^
        userId.hashCode ^
        saldo.hashCode;
  }
}
