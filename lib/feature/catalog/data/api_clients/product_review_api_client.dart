import 'package:graphql/client.dart';

import '../models/product_review_album_model.dart';
import '../models/product_review_comment_model.dart';
import '../models/product_review_model.dart';
import '../models/set_product_review_comment_request_model.dart';
import '../models/set_product_review_request_model.dart';

abstract interface class IProductReviewApiClient {
  Future<List<ProductReviewModel>> getReviews(int productId);

  Future<ProductReviewAlbumModel> getReviewAlbum(String reviewId);

  Future<ProductReviewModel> addReview(
    int productId,
    SetProductReviewRequestModel request,
  );

  Future<ProductReviewModel> updateReview(
    String reviewId,
    SetProductReviewRequestModel request,
  );

  Future<void> deleteReview(String reviewId);

  Future<ProductReviewCommentModel> addComment(
    String reviewId,
    SetProductReviewCommentRequestModel request,
  );

  Future<ProductReviewCommentModel> updateComment(
    String commentId,
    SetProductReviewCommentRequestModel request,
  );

  Future<void> deleteComment(String commentId);
}

class ProductReviewApiClient implements IProductReviewApiClient {
  ProductReviewApiClient({required GraphQLClient client}) : _client = client;

  final GraphQLClient _client;

  @override
  Future<List<ProductReviewModel>> getReviews(int productId) async {
    const query = r'''
      query GetReviews($pId: ID!) {
        post (id: $pId){
          id
          title 
          body
          user {
            id
            username
          }
          comments {
            data {
              id
              name
              body
            }
          }
      }
    }
    ''';

    final options = QueryOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'pId': productId,
      },
      parserFn: (data) => ProductReviewModel.fromJson(data['post'] as Map<String, dynamic>),
    );

    final result = await _client.query(options);
    return [result.parsedData!];
  }

  @override
  Future<ProductReviewAlbumModel> getReviewAlbum(String reviewId) async {
    const query = r'''
      query GetAlbum($aId: ID!) {
        album(id: $aId) {
          id
          photos {
            data {
              thumbnailUrl
              url
            }
          }
        }
      }
    ''';

    final options = QueryOptions(
        document: gql(query),
        variables: <String, dynamic>{
          'aId': reviewId,
        },
        parserFn: (data) =>
            ProductReviewAlbumModel.fromJson(data['album'] as Map<String, dynamic>));

    final result = await _client.query(options);
    return result.parsedData!;
  }

  @override
  Future<ProductReviewCommentModel> addComment(
    String reviewId,
    SetProductReviewCommentRequestModel request,
  ) async {
    const query = r'''
      mutation CreateComment($input: CreateCommentInput!) {
        createComment (input: $input){
          id
          name 
          body
      }
    }
    ''';

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'input': request.toJson(),
      },
      parserFn: (data) => data['createComment'] as Map<String, dynamic>,
    );

    final result = await _client.mutate(options);
    return ProductReviewCommentModel.fromJson(result.parsedData!);
  }

  @override
  Future<ProductReviewModel> addReview(int productId, SetProductReviewRequestModel request) async {
    const query = r'''
      mutation CreatePost($input: CreatePostInput!) {
        createPost (input: $input){
          id
          title 
          body
      }
    }
    ''';

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'pId': productId,
        'input': request.toJson(),
      },
      parserFn: (data) => ProductReviewModel.fromJson(data['createPost'] as Map<String, dynamic>),
    );

    final result = await _client.mutate(options);
    return result.parsedData!;
  }

  @override
  Future<void> deleteComment(String commentId) async {
    const query = r'''
      mutation (
        $cId: ID!
      ) {
        deleteComment(id: $cId)
      }
    ''';

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'cId': commentId,
      },
    );

    await _client.mutate(options);
  }

  @override
  Future<ProductReviewCommentModel> updateComment(
    String commentId,
    SetProductReviewCommentRequestModel request,
  ) async {
    const query = r'''
      mutation UpdateComment($rId: ID!, $input: UpdateCommentInput!) {
        updateComment (id: $rId, input: $input){
          name 
          body
      }
    }
    ''';

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'rId': commentId,
        'input': request.toJson(),
      },
      parserFn: (data) {
        final json = data['updateComment'] as Map<String, dynamic>;
        json['id'] = commentId;
        return ProductReviewCommentModel.fromJson(json);
      }
    );

    final result = await _client.mutate(options);
    return result.parsedData!;
  }

  @override
  Future<ProductReviewModel> updateReview(
    String reviewId,
    SetProductReviewRequestModel request,
  ) async {
    const query = r'''
      mutation UpdatePost($rId: ID!, $input: UpdatePostInput!) {
        updatePost (id: $rId, input: $input){
          title 
          body
      }
    }
    ''';

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'rId': reviewId,
        'input': request.toJson(),
      },
      parserFn: (data) {
        final json = data['updatePost'] as Map<String, dynamic>;
        json['id'] = reviewId;
        return ProductReviewModel.fromJson(json);
      }
    );

    final result = await _client.mutate(options);
    return result.parsedData!;
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    const query = r'''
      mutation (
        $rId: ID!
      ) {
        deletePost(id: $rId)
      }
    ''';

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'rId': reviewId,
      },
    );

    await _client.mutate(options);
  }
}
