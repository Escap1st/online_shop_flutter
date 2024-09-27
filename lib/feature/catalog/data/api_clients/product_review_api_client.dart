import 'package:graphql/client.dart';

import '../models/product_review_album_model.dart';
import '../models/product_review_comment_model.dart';
import '../models/product_review_model.dart';

abstract interface class IProductReviewApiClient {
  Future<List<ProductReviewModel>> getReviews(int productId);

  Future<ProductReviewAlbumModel> getReviewAlbum(String reviewId);

  Future<ProductReviewModel> addReview(int productId, ProductReviewModel review);

  Future<ProductReviewModel> updateReview(ProductReviewModel review);

  Future<void> deleteReview(int reviewId);

  Future<ProductReviewCommentModel> addComment(int reviewId, ProductReviewCommentModel comment);

  Future<ProductReviewCommentModel> updateComment(ProductReviewCommentModel comment);

  Future<void> deleteComment(int commentId);
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
    );

    final response = await _client.query(options);
    return [
      ProductReviewModel.fromJson(response.data!['post'] as Map<String, dynamic>),
    ];
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
    );

    final result = await _client.query(options);
    return ProductReviewAlbumModel.fromJson(result.data!['album'] as Map<String, dynamic>);
  }

  @override
  Future<ProductReviewCommentModel> addComment(
    int reviewId,
    ProductReviewCommentModel comment,
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
        'input': comment.toJson(),
      },
    );

    final response = await _client.mutate(options);
    return ProductReviewCommentModel.fromJson(
      response.data!['createComment'] as Map<String, dynamic>,
    );
  }

  @override
  Future<ProductReviewModel> addReview(int productId, ProductReviewModel review) async {
    const query = r'''
      mutation CreatePost($input: CreatePostInput!) {
        createPost (input: $input){
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

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'pId': productId,
        'input': review.toJson(),
      },
    );

    final response = await _client.mutate(options);
    return ProductReviewModel.fromJson(response.data!['createPost'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteComment(int commentId) async {
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
  Future<ProductReviewCommentModel> updateComment(ProductReviewCommentModel comment) async {
    const query = r'''
      mutation UpdateComment($rId: ID!, $input: UpdateCommentInput!) {
        updateComment (id: $rId, input: $input){
          id
          name 
          body
      }
    }
    ''';

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'rId': comment.id,
        'input': comment.toJson(),
      },
    );

    final response = await _client.mutate(options);
    return ProductReviewCommentModel.fromJson(
      response.data!['updateComment'] as Map<String, dynamic>,
    );
  }

  @override
  Future<ProductReviewModel> updateReview(ProductReviewModel review) async {
    const query = r'''
      mutation UpdatePost($rId: ID!, $input: UpdatePostInput!) {
        updatePost (id: $rId, input: $input){
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

    final options = MutationOptions(
      document: gql(query),
      variables: <String, dynamic>{
        'rId': review,
        'input': review.toJson(),
      },
    );

    final response = await _client.mutate(options);
    return ProductReviewModel.fromJson(response.data!['updatePost'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteReview(int reviewId) async {
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
