import 'package:tut_app/app/extension.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/network/remote_data_source.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';

import 'package:tut_app/data/network/request.dart';

import 'package:tut_app/data/network/failure.dart';

import 'package:dartz/dartz.dart';

import '../domain/repository/repository.dart';
import 'network/error_handler.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(request);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.failure, response.message.orEmpty()));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordModel>> forgetPassword(
      ForgetPasswordRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgetPassword(request);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.failure, response.message.orEmpty()));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
