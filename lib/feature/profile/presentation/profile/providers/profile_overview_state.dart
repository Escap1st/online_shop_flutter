part of 'profile_overview_provider.dart';

class ProfileOverviewState extends Equatable {
  const ProfileOverviewState({
    required this.login,
    this.favoriteProducts,
    this.orders,
  });

  final String? login;
  final List<Product>? favoriteProducts;
  final List<Order>? orders;

  @override
  List<Object?> get props => [login, favoriteProducts, orders];

  ProfileOverviewState copyWith({
    String? login,
    List<Product>? favoriteProducts,
    List<Order>? orders,
  }) {
    return ProfileOverviewState(
      login: login ?? this.login,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      orders: orders ?? this.orders,
    );
  }
}
