import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/app/extension.dart';
import 'package:tut_app/data/network/failure.dart';

import '../../presentation/resources/string_manger.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.response:
        if (error.response != null) {
          return Failure(error.response!.statusCode.orZero(),
              error.response!.statusMessage.orEmpty());
        } else {
          return DataSource.unknown.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.cancelled.getFailure();
      case DioErrorType.other:
        return DataSource.unknown.getFailure();
    }
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancelled,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404;
  // local status code
  static const int connectTimeout = -1; //
  static const int cancelled = -2; //
  static const int receiveTimeout = -3; //
  static const int sendTimeout = -4; //
  static const int cacheError = -5; //
  static const int noInternetConnection = -6; //
  static const int unknown = -7; //
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, StringManger.success.tr());
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, StringManger.noContent.tr());
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, StringManger.badRequest.tr());
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, StringManger.forbidden.tr());
      case DataSource.unauthorized:
        return Failure(
            ResponseCode.unauthorized, StringManger.unauthorized.tr());
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, StringManger.notFound.tr());
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            StringManger.internalServerError.tr());
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, StringManger.connectTimeout.tr());
      case DataSource.cancelled:
        return Failure(ResponseCode.cancelled, StringManger.cancelled.tr());
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, StringManger.receiveTimeout.tr());
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, StringManger.sendTimeout.tr());
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, StringManger.cacheError.tr());
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            StringManger.noInternetConnection.tr());
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, StringManger.unknown.tr());
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
