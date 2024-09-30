import 'package:equatable/equatable.dart';

class SetProductReviewCommentRequest extends Equatable {
  const SetProductReviewCommentRequest({required this.body, this.name, this.email = ''});

  final String? name;
  final String body;
  final String email;

  @override
  List<Object?> get props => [name, body, email];

  SetProductReviewCommentRequest copyWith({
    String? name,
    String? body,
    String? email,
  }) {
    return SetProductReviewCommentRequest(
      name: name ?? this.name,
      body: body ?? this.body,
      email: email ?? this.email,
    );
  }
}
