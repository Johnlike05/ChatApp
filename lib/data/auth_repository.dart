import 'package:chatquick/domain/models/auth_user.dart';

abstract class AuthRepository {
  //solo obtenemos este metodo para saber si el usuario esta logueado
  Future<AuthUser> getAuthUser();
  //este para autenticarse
  Future<AuthUser> signIn();
  //este para salir
  Future<void> logout();
}