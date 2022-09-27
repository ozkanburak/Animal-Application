import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  //Register
  Future registerUser(
      String email, String password, String displayName, String phone) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user?.updateDisplayName(displayName);
      await user?.updateEmail(email);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SignOut
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  //Sign in with mail and password
  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
