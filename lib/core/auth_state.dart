import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateProvider.autoDispose<AuthState>((ref) => AuthState.none);

enum AuthState {
  email,
  google,
  none,
}
