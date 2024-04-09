import 'package:dio/dio.dart';

import '../exceptions/app_exception.dart';
import '../exceptions/common_exceptions.dart';
import '../exceptions/network_exceptions.dart';

extension NetworkCallErrorHandling<T> on Future<T> {
  Future<T> handleErrors() async {
    try {
      final result = await this;
      return result;
    } on DioException catch (e, st) {
      if (e.error is AppException) {
        Error.throwWithStackTrace(e.error!, st);
      } else {
        Error.throwWithStackTrace(UnknownException(), st);
      }
    } on TypeError catch (e, st) {
      Error.throwWithStackTrace(ParsingException(), st);
    } catch (e, st) {
      Error.throwWithStackTrace(UnknownException(), st);
    }
  }
}
