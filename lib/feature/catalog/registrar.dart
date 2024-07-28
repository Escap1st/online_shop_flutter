import '../../core/di/dependencies.dart';
import '../../core/di/registrar.dart';
import 'data/api_clients/product_api_client.dart';
import 'data/api_clients/product_review_api_client.dart';
import 'data/repositories/product_repository.dart';
import 'domain/catalog_service.dart';
import 'domain/repositories/product_repository.dart';
import 'presentation/catalog/providers/catalog/catalog_provider.dart';
import 'presentation/catalog/providers/product_list/product_list_provider.dart';
import 'presentation/catalog_filter/providers/catalog_filter_provider/catalog_filter_provider.dart';
import 'presentation/catalog_filter/providers/catalog_filters_data_provider/catalog_filters_data_provider.dart';
import 'presentation/catalog_filter/providers/product_categories_provider.dart';
import 'presentation/common_providers/products_by_ids_provider.dart';
import 'presentation/product_details/providers/product_details_provider.dart';
import 'presentation/product_reviews/providers/product_reviews_provider.dart';

class CatalogRegistrar implements IRegistrar {
  @override
  void register() {
    registerLazySingletonDependency<IProductApiClient>(
      () => IProductApiClient(resolveDependency()),
    );
    registerLazySingletonDependency<IProductReviewApiClient>(
      () => ProductReviewApiClient(client: resolveDependency()),
    );
    registerLazySingletonDependency<IProductRepository>(
      () => ProductRepository(
        productApiClient: resolveDependency(),
        productReviewApiClient: resolveDependency(),
      ),
    );
    registerLazySingletonDependency<ICatalogService>(
      () => CatalogService(productRepository: resolveDependency()),
    );
    registerFactoryDependency(
      () => ProductListNotifier(catalogService: resolveDependency()),
    );
    registerFactoryDependency(
      () => ProductCategoriesNotifier(
        catalogService: resolveDependency(),
      ),
    );
    registerFactoryDependency(CatalogFilterNotifier.new);
    registerFactoryDependency(CatalogFiltersDataNotifier.new);
    registerFactoryDependency(CatalogNotifier.new);
    registerFactoryDependency(
      () => ProductDetailsNotifier(
        catalogService: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => ProductReviewsNotifier(
        catalogService: resolveDependency(),
      ),
    );
    registerFactoryDependency(
      () => ProductsByIdsNotifier(
        catalogService: resolveDependency(),
      ),
    );
  }
}
