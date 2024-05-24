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

  PagedResponse<T> copyWith({
    List<T>? items,
    int? total,
    int? skip,
    int? limit,
  }) {
    return PagedResponse(
      items: items ?? this.items,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }
}
