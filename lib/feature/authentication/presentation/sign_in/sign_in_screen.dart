import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/di/dependencies.dart';
import '../../../../core/error_handler.dart';
import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import 'providers/sign_in_email_provider.dart';
import 'providers/sign_in_google_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignInScreen> {
  late final _emailKey = GlobalKey<FormFieldState<String>>();
  late final _passwordKey = GlobalKey<FormFieldState<String>>();
  late final _emailTextController = TextEditingController();
  late final _passwordTextController = TextEditingController();

  var _isLoginValid = false;
  var _isPasswordValid = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setListeners(ref);

    final signInEmailState = ref.watch(signInEmailProvider);

    const inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: _emailKey,
                controller: _emailTextController,
                enabled: !signInEmailState.isLoading,
                decoration: inputDecoration.copyWith(labelText: 'Email'),
                textInputAction: TextInputAction.next,
                validator: _emailValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) {
                  if (_emailKey.currentState?.isValid != _isLoginValid) {
                    setState(() => _isLoginValid ^= true);
                  }
                },
              ),
              const Gap.v(12),
              TextFormField(
                key: _passwordKey,
                enabled: !signInEmailState.isLoading,
                controller: _passwordTextController,
                decoration: inputDecoration.copyWith(labelText: 'Password'),
                obscureText: true,
                validator: _nonEmptyValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) {
                  if (_passwordKey.currentState?.isValid != _isPasswordValid) {
                    setState(() => _isPasswordValid ^= true);
                  }
                },
              ),
              const Gap.v(12),
              ElevatedButton(
                onPressed: !signInEmailState.isLoading && _areFieldsValid()
                    ? () => ref.read(signInEmailProvider.notifier).signIn(
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                        )
                    : null,
                child: signInEmailState.isLoading
                    ? const SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Confirm credentials'),
              ),
              const Gap.v(16),
              const Divider(),
              const Gap.v(16),
              Text(
                'Alternatively, use your social account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap.v(12),
              UnconstrainedBox(
                child: ClipOval(
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    onTap: ref.read(signInGoogleProvider.notifier).signIn,
                    child: Image.asset(
                      'assets/images/google.png',
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setListeners(WidgetRef ref) {
    ref.listen(
      signInEmailProvider,
      (previous, next) {
        switch (next) {
          case AsyncData(:final value) when value == true:
            ref.read(authStateProvider.notifier).state = AuthState.email;
            const OrderDetailsRoute().go(context);
          case AsyncError(:final error, :final stackTrace):
            resolveDependency<IErrorHandler>().showNotification(
              context,
              error: error,
              stackTrace: stackTrace,
            );
        }
      },
    );

    ref.listen(
      signInGoogleProvider,
      (previous, next) {
        switch (next) {
          case AsyncData(:final value) when value == true:
            ref.read(authStateProvider.notifier).state = AuthState.google;
            const OrderDetailsRoute().go(context);
          case AsyncError(:final error, :final stackTrace):
            resolveDependency<IErrorHandler>().showNotification(
              context,
              error: error,
              stackTrace: stackTrace,
            );
        }
      },
    );
  }

  String? _emailValidator(String? value) {
    return RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value ?? '')
        ? null
        : 'Wrong email format';
  }

  String? _nonEmptyValidator(String? value) =>
      (value?.isEmpty ?? true) ? 'Should not be empty' : null;

  bool _areFieldsValid() {
    return _isPasswordValid && _isLoginValid;
  }
}
