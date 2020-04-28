import 'package:firebase_auth/firebase_auth.dart';
import '../http/webclients/usuario_webclient.dart';
import '../locator.dart';
import '../models/usuario.dart';

class UsersService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UsuarioWebClient _usuarioWebClient = locator<UsuarioWebClient>();

  Future getUser() async => await _firebaseAuth.currentUser();

  Future<Usuario> getUsuario(String email) async {
    FirebaseUser fireUser = await getUser();
    Usuario _user = await _usuarioWebClient.findOneByEmail(fireUser.email);

    return _user;
  }
}
