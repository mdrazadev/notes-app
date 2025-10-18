import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/res/mixins/logger_mixin.dart';

class AuthService with LoggerMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SIGN UP:
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  // LOGIN:
  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } catch (e) {
      logError(e.toString());
      return null;
    }
  }

  // LOGOUT:
  Future<void> logout() async {
    await _auth.signOut();
  }

  // STREAM FOR AUTH CHANGE:
  Stream<User?> get userChanges => _auth.authStateChanges();
}
