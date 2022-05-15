import 'package:firebase_auth/firebase_auth.dart';
class AuthService {

Future signInAnon() async {
  try {
    final FirebaseAuth _auth =FirebaseAuth.instance;
    UserCredential result = await _auth.signInAnonymously();
    User? user = result.user;
    return user;
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
    return null;
  }
}
}