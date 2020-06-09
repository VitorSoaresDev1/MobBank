import 'package:firebase_auth/firebase_auth.dart';
import '../http/webclients/usuario_webclient.dart';
import '../locator.dart';
import '../models/usuario.dart';

class UsersService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UsuarioWebClient _usuarioWebClient = locator<UsuarioWebClient>();

  Future getUser() async => await _firebaseAuth.currentUser();

  Future<Usuario> getUsuario(String email) async =>
      await _usuarioWebClient.findOneByEmail(email);
}
