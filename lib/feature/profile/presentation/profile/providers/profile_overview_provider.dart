import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../../authentication/domain/authentication_service.dart';

part 'profile_overview_state.dart';

final profileOverviewProvider =
    StateNotifierProvider<ProfileOverviewNotifier, AsyncValue<ProfileOverviewState>>(
  (ref) => resolveDependency(),
);

class ProfileOverviewNotifier extends StateNotifier<AsyncValue<ProfileOverviewState>> {
  ProfileOverviewNotifier({required IAuthenticationService authenticationService})
      : _authenticationService = authenticationService,
        super(const AsyncLoading()) {
    load();
  }

  final IAuthenticationService _authenticationService;

  Future<void> load() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ProfileOverviewState(login: await _authenticationService.getLogin());
    });

    if (state is AsyncData) {
      await AsyncValue.guard(() async {
        // TODO: get counts
      });
    }
  }
}
