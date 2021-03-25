import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatquick/data/auth_repository.dart';
import 'package:chatquick/domain/models/auth_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthImpl extends AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUser> getAuthUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      return AuthUser(user.uid);
    }
    return null;
  }

  @override
  Future<AuthUser> signIn() async {
    try {
      UserCredential userCredential;
      print('$userCredential');
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      print('$googleUser');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('$googleAuth');
      final GoogleAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('$googleAuthCredential');
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;
      return AuthUser(user.uid);
    } catch (e) {
      print(e);
      throw Exception('login error');
    }
  }

  @override
  Future<void> logout() async {
    return _auth.signOut();
  }
}
