import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                decoration: inputDecoration.copyWith(hintText: 'Login'),
                textInputAction: TextInputAction.next,
              ),
              const Gap.v(12),
              TextFormField(
                decoration: inputDecoration.copyWith(hintText: 'Password'),
              ),
              const Gap.v(12),
              ElevatedButton(
                onPressed: () {
                  const OrderDetailsRoute().go(context);
                },
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
}
