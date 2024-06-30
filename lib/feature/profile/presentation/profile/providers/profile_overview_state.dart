part of 'profile_overview_provider.dart';

class ProfileOverviewState extends Equatable {
  const ProfileOverviewState({
    required this.login,
  });

  final String? login;

  @override
  List<Object?> get props => [login];

  ProfileOverviewState copyWith({
    String? login,
  }) {
    return ProfileOverviewState(
      login: login ?? this.login,
    );
  }
}
