import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'core/di/dependencies.dart';
import 'core/di/registrar.dart';
import 'core/log.dart';
import 'feature/authentication/registrar.dart';
import 'feature/cart/registrar.dart';
import 'feature/catalog/registrar.dart';

class AppRegistrar implements IRegistrar {
  @override
  void register() {
    registerLazySingletonDependency(
      () => Dio()
        ..interceptors.add(
          TalkerDioLogger(
            talker: talker,
            settings: const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
            ),
          ),
        ),
    );

    final featuresRegistrars = [
      AuthenticationRegistrar(),
      CatalogRegistrar(),
      CartRegistrar(),
    ];

    for (final e in featuresRegistrars) {
      e.register();
    }
  }
}
