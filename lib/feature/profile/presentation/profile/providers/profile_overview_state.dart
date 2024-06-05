part of 'profile_overview_provider.dart';

class ProfileOverviewState extends Equatable {
  const ProfileOverviewState({
    required this.login,
    this.favoritesCount,
    this.ordersCount,
  });

  final String? login;
  final int? favoritesCount;
  final int? ordersCount;

  @override
  List<Object?> get props => [login, favoritesCount, ordersCount];
}
