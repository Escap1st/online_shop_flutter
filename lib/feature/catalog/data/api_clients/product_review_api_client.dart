import 'package:graphql/client.dart';

import '../models/product_review_album_model.dart';
import '../models/product_review_model.dart';

abstract interface class IProductReviewApiClient {
  Future<List<ProductReviewModel>> getReviews(int productId);

  Future<ProductReviewAlbumModel> getReviewAlbum(String reviewId);
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
      ProductReviewModel.fromJson(response.data!),
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
    return ProductReviewAlbumModel.fromJson(result.data!);
  }
}
