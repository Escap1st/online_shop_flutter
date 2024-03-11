class PagedResponseModel {
  PagedResponseModel({
    required this.total,
    required this.skip,
    required this.limit,
  });

  final int total;
  final int skip;
  final int limit;
}
