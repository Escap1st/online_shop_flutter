import 'package:equatable/equatable.dart';

class PagedResponse<T> extends Equatable {
  const PagedResponse({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<T> items;
  final int total;
  final int skip;
  final int limit;

  @override
  List<Object?> get props => [items, total, skip, limit];
}
