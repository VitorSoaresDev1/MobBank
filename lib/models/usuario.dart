import 'dart:convert';

class Usuario {
  final int id;
  final String nome;
  final String email;
  final String senha;

  Usuario({
    this.id,
    this.nome,
    this.email,
    this.senha,
  });

  get firstName => this.nome.split(' ')[0];

  get lastName => this.nome.split(' ')[(this.nome.split(' ').length - 1)];

  get cardInitials {
    String nameWithInitials = '';
    List<String> initials = this.nome.split(' ');
    for (var i = 0; i < initials.length; i++) {
      if (i == 0 || i == initials.length - 1) {
        nameWithInitials += '${initials[i]} ';
      } else {
        nameWithInitials += '${initials[i].substring(0, 1)}. ';
      }
    }
    return nameWithInitials;
  }

  get initials {
    return '${firstName.substring(0, 1)}${lastName.substring(0, 1)}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'initials': cardInitials,
      'firstName': firstName,
      'lastName': lastName,
      'senha': senha,
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Usuario(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  String toJson() => json.encode(toMap());

  static Usuario fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Usuario && o.nome == nome && o.email == email;
  }

  @override
  int get hashCode {
    return nome.hashCode ^ email.hashCode;
  }
}
