import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository();

  final auth = FirebaseAuth.instance;

  Stream<User> userStream() {
    return auth.authStateChanges();
  }

  Future<void> createUser(String email, String password) {
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInUser(String email, String password) {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOutUser() {
    return auth.signOut();
  }
}
