import 'package:get_it/get_it.dart';

import '../log.dart';

T resolveDependency<T extends Object>({String? instanceName}) {
  try {
    return GetIt.instance<T>(instanceName: instanceName);
  } catch (e, stackTrace) {
    logError('failed resolving dependency', e, stackTrace: stackTrace);
    rethrow;
  }
}

T? resolveDependencyOrNull<T extends Object>({String? instanceName}) {
  try {
    return GetIt.instance<T>(instanceName: instanceName);
  } catch (_) {
    return null;
  }
}

void registerLazySingletonDependency<T extends Object>(
  T Function() factory, {
  String? instanceName,
}) {
  GetIt.instance.registerLazySingleton<T>(factory, instanceName: instanceName);
}

void registerSingletonDependency<T extends Object>(T instance, {String? instanceName}) {
  GetIt.instance.registerSingleton<T>(instance, instanceName: instanceName);
}

void registerFactoryDependency<T extends Object>(
  T Function() factoryFunc, {
  String? instanceName,
}) {
  GetIt.instance.registerFactory<T>(factoryFunc, instanceName: instanceName);
}

void removeDependency<T extends Object>(T instance, {String? instanceName}) {
  GetIt.instance.unregister<T>(instance: instance, instanceName: instanceName);
}
