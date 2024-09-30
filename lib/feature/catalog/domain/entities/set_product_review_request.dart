import 'package:equatable/equatable.dart';

class SetProductReviewRequest extends Equatable {
  const SetProductReviewRequest({
    this.title,
    this.body,
  });

  final String? title;
  final String? body;

  @override
  List<Object?> get props => [title, body];

  SetProductReviewRequest copyWith({
    String? title,
    String? body,
  }) {
    return SetProductReviewRequest(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
