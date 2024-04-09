import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../exceptions/network_exceptions.dart';

class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor({required Connectivity connectivity}) : _connectivity = connectivity;

  final Connectivity _connectivity;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: NoInternetConnectionException(),
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
