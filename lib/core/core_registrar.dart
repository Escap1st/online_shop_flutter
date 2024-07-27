import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:graphql/client.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'di/dependencies.dart';
import 'di/registrar.dart';
import 'error_handler.dart' as eh;
import 'log.dart';
import 'network/connectivity_interceptor.dart';

class CoreRegistrar implements IRegistrar {
  @override
  void register() {
    registerLazySingletonDependency(
      () => Dio()
        ..interceptors.addAll(
          [
            TalkerDioLogger(
              talker: talker,
              settings: const TalkerDioLoggerSettings(
                printRequestHeaders: true,
                printResponseHeaders: true,
              ),
            ),
            ConnectivityInterceptor(
              connectivity: Connectivity(),
            ),
          ],
        ),
    );

    registerLazySingletonDependency(() {
      final link = HttpLink(
        'https://graphqlzero.almansi.me/api',
      );

      return GraphQLClient(
        link: link,
        cache: GraphQLCache(),
      );
    });

    registerLazySingletonDependency<eh.IErrorHandler>(eh.ErrorHandler.new);
  }
}
