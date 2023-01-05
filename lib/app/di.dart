import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_preferences.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/network/remote_data_source.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/login_use_case.dart';
import 'package:tut_app/domain/use_case/register_use_case.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view_model/forget_password_view_model.dart';
import 'package:tut_app/presentation/login/login_view_model/login_view_model.dart';
import 'package:tut_app/presentation/register/register_view_model/register_view_model.dart';
import '../data/repository.dart';
import '../domain/use_case/forget_password_use_case.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  //sharedPreferences
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  //App preference
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  //dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(instance<AppPreferences>()));
  //app service client
  Dio dio = await instance<DioFactory>().getDio();
  instance
      .registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));
  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServicesClient>()));
//network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  //repository
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<Repository>()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(instance<LoginUseCase>()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(instance<Repository>()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance<RegisterUseCase>()));
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance<Repository>()));
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance<ForgetPasswordUseCase>()));
  }
}
