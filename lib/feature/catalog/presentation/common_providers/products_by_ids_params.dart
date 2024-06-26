import 'package:equatable/equatable.dart';

class ProductByIdsParams extends Equatable {
  const ProductByIdsParams({required this.ids});

  final List<int> ids;

  @override
  List<Object?> get props => [ids];
}
