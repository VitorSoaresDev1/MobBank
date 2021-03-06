import 'dart:convert';

class Deposit {
  final String uuid;
  final double value;
  final int cardId;
  final int transferTo;
  final int tipo;
  final String senha;
  final DateTime dataRealizacao;

  Deposit(
    this.uuid,
    this.value,
    this.cardId,
    this.transferTo,
    this.tipo,
    this.senha,
    this.dataRealizacao,
  ) : assert(value > 0);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'value': value,
      'cardId': cardId,
      'transferTo': transferTo,
      'tipo': tipo,
      'senha': senha,
      'dataRealizacao': dataRealizacao?.millisecondsSinceEpoch,
    };
  }

  static Deposit fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Deposit(
      map['uuid'],
      map['value'],
      map['cardId'],
      map['transferTo'],
      map['tipo'],
      map['senha'],
      DateTime.parse(map['dataRealizacao']),
    );
  }

  String toJson() => json.encode(toMap());

  static Deposit fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Deposit(uuid: $uuid, value: $value, cardId: $cardId, transferTo: $transferTo, tipo: $tipo, senha: $senha, dataRealizacao: $dataRealizacao)';
  }
}
