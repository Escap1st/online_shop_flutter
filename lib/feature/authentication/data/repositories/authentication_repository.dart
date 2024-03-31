import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/sign_in_email_params.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<void> signInEmail({required SignInEmailParams params}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user');
      } else if (e.code == 'invalid-credential') {
        throw Exception('The supplied auth credential is incorrect, malformed or has expired.');
      } else {
        throw Exception(e.message);
      }
    }
  }

  @override
  Future<void> signInGoogle() async {
    final scopes = ['email'];
    final googleSignIn = GoogleSignIn(scopes: scopes);
    final account = await googleSignIn.signIn();
    if (account != null) {
      // TODO: save to not re-authenticate
    } else {
      throw Exception('Could not authenticate using google sing in');
    }
  }
}
