import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/exceptions/common_exceptions.dart';
import '../../domain/entities/exceptions.dart';
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
    } on FirebaseAuthException catch (e, st) {
      AppException appException;
      if (e.code == 'user-not-found') {
        appException = FirebaseAuthUserNotFoundException();
      } else if (e.code == 'wrong-password') {
        appException = FirebaseAuthWrongPasswordException();
      } else if (e.code == 'invalid-credential') {
        appException = FirebaseAuthInvalidCredentialException();
      } else {
        appException = FirebaseAuthFailedException();
      }

      Error.throwWithStackTrace(appException, st);
    } catch (e, st) {
      Error.throwWithStackTrace(UnknownException(), st);
    }
  }

  @override
  Future<void> signInGoogle() async {
    GoogleSignInAccount? account;

    try {
      final scopes = ['email'];
      final googleSignIn = GoogleSignIn(scopes: scopes);
      account = await googleSignIn.signIn();
    } catch (e, st) {
      Error.throwWithStackTrace(UnknownException(), st);
    }

    if (account != null) {
      // TODO: save to not re-authenticate
    } else {
      throw GoogleSignInFailedException();
    }
  }
}
