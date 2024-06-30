import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/dependencies.dart';
import '../../../../authentication/domain/authentication_service.dart';

part 'profile_overview_state.dart';

final profileOverviewProvider =
    AsyncNotifierProvider<ProfileOverviewNotifier, ProfileOverviewState>(
  resolveDependency,
);

class ProfileOverviewNotifier extends AsyncNotifier<ProfileOverviewState> {
  ProfileOverviewNotifier({
    required IAuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final IAuthenticationService _authenticationService;

  @override
  FutureOr<ProfileOverviewState> build() async {
    return ProfileOverviewState(
      login: await _authenticationService.getLogin(),
    );
  }
}
