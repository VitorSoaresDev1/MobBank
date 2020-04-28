import 'dart:convert';

class Usuario {
  final int id;
  final String nome;
  final String email;

  int getId() => this.id;

  String getNome() => this.nome;

  String getEmail() => this.email;

  Usuario({
    this.id,
    this.nome,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  static Usuario fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Usuario( nome: $nome, email: $email)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Usuario && o.nome == nome && o.email == email;
  }

  @override
  int get hashCode => nome.hashCode ^ email.hashCode;
}
