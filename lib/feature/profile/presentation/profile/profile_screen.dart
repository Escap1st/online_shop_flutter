import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth_state.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/kit_button.dart';
import '../../../../shared/presentation/widgets/screen_error_widget.dart';
import '../../../../shared/presentation/widgets/screen_loading_widget.dart';
import '../../../authentication/presentation/common_providers/check_authentication_provider.dart';
import '../../../authentication/presentation/common_providers/log_out_provider.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap.v(48),
            Center(
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: theme.colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.person_outline,
                    color: theme.colorScheme.onSecondaryContainer,
                    size: 56,
                  ),
                ),
              ),
            ),
            const Gap.v(16),
            Text(
              state.login ?? 'Lovely user',
              style: theme.textTheme.titleLarge,
            ),
            const Gap.v(48),
            _ListItem(
              icon: Icons.watch_later_outlined,
              label: 'Orders history',
              trailing: state.ordersCount?.let((it) => _Badge(value: it)),
              onPressed: () {},
            ),
            _ListItem(
              icon: Icons.favorite_outline,
              label: 'Favorites',
              trailing: state.favoritesCount?.let((it) => _Badge(value: it)),
              onPressed: () {},
            ),
            const Spacer(),
            _ListItem(
              icon: Icons.logout,
              label: 'Log out',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const _LogoutDialog(),
                );
              },
            ),
            const Gap.v(16),
          ],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.icon,
    required this.label,
    super.key,
    this.trailing,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
            ),
            const Gap.h(16),
            Expanded(
                child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            )),
            if (trailing != null) ...[
              const Gap.h(16),
              trailing!,
            ]
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.value, super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Badge(
      label: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 24),
        child: Text(
          value.toString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSecondaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      largeSize: 24,
      backgroundColor: theme.colorScheme.secondaryContainer,
    );
  }
}

class _LogoutDialog extends ConsumerWidget {
  const _LogoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Do you really want to be logged out?'),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await ref.read(logOutProvider.notifier).call();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Yes, I do'),
        ),
      ],
    );
  }
}
