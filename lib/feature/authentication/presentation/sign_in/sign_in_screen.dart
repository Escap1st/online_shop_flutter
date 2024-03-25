import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignInScreen> {
  late final _loginKey = GlobalKey<FormFieldState<String>>();
  late final _passwordKey = GlobalKey<FormFieldState<String>>();
  late final _loginTextController = TextEditingController();
  late final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _loginTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                key: _loginKey,
                controller: _loginTextController,
                decoration: inputDecoration.copyWith(hintText: 'Login'),
                textInputAction: TextInputAction.next,
                validator: (value) => (value?.isEmpty ?? true) ? 'Should not be empty' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) => setState(() {}),
              ),
              const Gap.v(12),
              TextFormField(
                key: _passwordKey,
                controller: _passwordTextController,
                decoration: inputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (value) => (value?.isEmpty ?? true) ? 'Should not be empty' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) => setState(() {}),
              ),
              const Gap.v(12),
              ElevatedButton(
                onPressed: _areFieldsValid()
                    ? () {
                        ref.read(authStateProvider.notifier).state = AuthState.email;
                        const OrderDetailsRoute().go(context);
                      }
                    : null,
                child: const Text('Confirm credentials'),
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
                    onTap: () {
                      ref.read(authStateProvider.notifier).state = AuthState.google;
                      const OrderDetailsRoute().go(context);
                    },
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

  bool _areFieldsValid() {
    return (_loginKey.currentState?.isValid ?? false) &&
        (_passwordKey.currentState?.isValid ?? false);
  }
}
