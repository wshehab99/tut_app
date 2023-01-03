import 'package:dio/dio.dart';
import 'package:tut_app/app/extension.dart';
import 'package:tut_app/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(error) {
    if (error is DioError) {
      print(error.message);
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

class ResponseMessage {
  static const String success = "Success"; // success with data
  static const String noContent =
      "Success"; // success with no data (no content)
  static const String badRequest =
      "Bad request, Try again later"; // failure, API rejected request
  static const String unauthorized =
      "You are not authorized to do that"; // failure, user is not authorized
  static const String forbidden =
      "Forbidden request, Try again later"; //  failure, API rejected request
  static const String internalServerError =
      "Something went wrong try again later."; // failure, crash in server side
  static const String notFound =
      "Content not found, try again later."; // failure,
  // local status code
  static const String connectTimeout =
      "Connection take a long time, Please check your internet connection and try again later."; //
  static const String cancelled = "Request was cancelled."; //
  static const String receiveTimeout =
      "Receive take a long time, Please check your internet connection and try again later."; //
  static const String sendTimeout =
      "Send take a long time, Please check your internet connection and try again later."; //
  static const String cacheError = "Cache error, try again later."; //
  static const String noInternetConnection =
      "No internet connection, Please check your internet connection and try again later."; //
  static const String unknown =
      "Something went wrong, Please try again later"; //
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancelled:
        return Failure(ResponseCode.cancelled, ResponseMessage.cancelled);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
