import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/exceptions/common_exceptions.dart';
import '../../domain/entities/exceptions.dart';
import '../../domain/entities/sign_in_email_params.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  AuthenticationRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<bool> isAuthenticated() async {
    return _firebaseAuth.currentUser != null || _googleSignIn.currentUser != null;
  }

  @override
  Future<AuthState> getAuthenticationState() async {
    if (_firebaseAuth.currentUser != null) {
      return AuthState.email;
    } else if (_googleSignIn.currentUser != null) {
      return AuthState.google;
    } else {
      return AuthState.none;
    }
  }

  @override
  Future<String?> getUserId() async {
    return _firebaseAuth.currentUser?.uid ?? _googleSignIn.currentUser?.id;
  }

  @override
  Future<String?> getLogin() async {
    return _firebaseAuth.currentUser?.email ?? _googleSignIn.currentUser?.email;
  }

  @override
  Future<void> signInEmail({required SignInEmailParams params}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
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
      account = await _googleSignIn.signIn();
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
