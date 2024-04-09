import '../../../../core/exceptions/app_exception.dart';

class GoogleSignInFailedException implements AppException {}

class FirebaseAuthWrongPasswordException implements AppException {}

class FirebaseAuthUserNotFoundException implements AppException {}

class FirebaseAuthInvalidCredentialException implements AppException {}

class FirebaseAuthFailedException implements AppException {}
