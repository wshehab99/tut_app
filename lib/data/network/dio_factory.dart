import 'package:dio/dio.dart';
import 'package:tut_app/app/constants.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      AppConstants.contentType: AppConstants.applicationJson,
      AppConstants.accept: AppConstants.applicationJson,
      AppConstants.authorization: "", //todo
      AppConstants.language: "en",
    };
    dio.options = BaseOptions(
      headers: headers,
      sendTimeout: AppConstants.timeOut,
      connectTimeout: AppConstants.timeOut,
      receiveTimeout: AppConstants.timeOut,
    );
     if (!kReleaseMode) { // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
