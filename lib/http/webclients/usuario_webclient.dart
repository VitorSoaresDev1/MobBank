import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobbank/constants/webclient_urls.dart';
import 'package:mobbank/http/webclient.dart';
import 'package:mobbank/models/usuario.dart';

class UsuarioWebClient {
  Future<List<Usuario>> findAll() async {
    final Response response = await client.get(USERS_URL);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Usuario.fromJson(json)).toList();
  }

  Future<Usuario> findOneByEmail(String email) async {
    final Response response = await client.get('$USERS_URL/byemail/$email');

    if (response.statusCode == 200) {
      return Usuario.fromJson(response.body);
    }

    throw new HttpException(_getMessage(response.statusCode));
  }

  Future<Usuario> findOneById(int id) async {
    final Response response = await client.get('$USERS_URL/$id');

    if (response.statusCode == 200) {
      return Usuario.fromJson(response.body);
    }

    throw new HttpException(_getMessage(response.statusCode));
  }

  Future<Usuario> save(Usuario usuario) async {
    final String usuarioJson = usuario.toJson();

    await Future.delayed(Duration(seconds: 5));
    final Response response = await client.post(USERS_URL,
        headers: {
          'Content-type': 'application/json',
        },
        body: usuarioJson);

    if (response.statusCode == 201) {
      return Usuario.fromJson(response.body);
    }

    throw new HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submiting the transaction',
    401: 'Authentication Failed',
    409: 'Transaction already exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
