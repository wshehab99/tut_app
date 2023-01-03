import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_app/app/app_preferences.dart';
import 'package:tut_app/app/constants.dart';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      AppConstants.contentType: AppConstants.applicationJson,
      AppConstants.accept: AppConstants.applicationJson,
      AppConstants.authorization: "", //todo
      AppConstants.language: await _appPreferences.getAppLanguage(),
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseURL,
      headers: headers,
      sendTimeout: AppConstants.timeOut,
      connectTimeout: AppConstants.timeOut,
      receiveTimeout: AppConstants.timeOut,
      followRedirects: false,
    );
    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
