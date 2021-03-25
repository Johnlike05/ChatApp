import 'package:chatquick/data/auth_repository.dart';
import 'package:chatquick/domain/models/auth_user.dart';

class AuthLocalImpl extends AuthRepository {
  @override
  Future<AuthUser> getAuthUser() async {
    //hacemos una pausa para simular que estoy consultando
    await Future.delayed(const Duration(seconds: 2));
    //id john solo para prueba
    return AuthUser('diego');
  }
  @override
  Future<AuthUser> signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('diego');

  }
  @override
  Future<void> logout() async {
    return;
  }
  
}