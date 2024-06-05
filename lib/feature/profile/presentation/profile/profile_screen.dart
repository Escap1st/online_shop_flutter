import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/routing/routes.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/kit_button.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../../authentication/presentation/common_providers/check_authentication_provider.dart';
import 'providers/profile_overview_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(checkAuthenticationProvider.notifier).check();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final checkAuthenticationState = ref.watch(checkAuthenticationProvider);
    switch (checkAuthenticationState) {
      case AsyncLoading():
      case AsyncValue(:final value) when value == null:
        return const ScreenLoadingWidget();
    }

    final authState = ref.watch(authStateProvider);
    return authState == AuthState.none ? const _AuthSuggestion() : const _Authenticated();
  }
}

class _AuthSuggestion extends StatelessWidget {
  const _AuthSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'You are not authenticated yet',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Gap.v(16),
              FractionallySizedBox(
                widthFactor: 0.33,
                child: KitButton(
                  label: 'Sign in',
                  onPressed: () => const ProfileSignInRoute().go(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Authenticated extends ConsumerWidget {
  const _Authenticated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileOverviewState = ref.watch(profileOverviewProvider);

    return switch (profileOverviewState) {
      AsyncLoading() => const ScreenLoadingWidget(),
      AsyncData(:final value) => _Loaded(state: value),
      AsyncError(:final error, :final stackTrace) => ScreenErrorWidget(
          error: error,
          stackTrace: stackTrace,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.state, super.key});

  final ProfileOverviewState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap.v(32),
            Center(
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: const Icon(
                    Icons.person_outline,
                    size: 56,
                  ),
                ),
              ),
            ),
            const Gap.v(16),
            Text(
              state.login ?? 'Lovely user',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap.v(32),
          ],
        ),
      ),
    );
  }
}
