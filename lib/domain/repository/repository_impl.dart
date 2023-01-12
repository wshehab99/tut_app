import 'package:tut_app/app/extension.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';

import 'package:tut_app/data/network/request.dart';

import 'package:tut_app/data/network/failure.dart';

import 'package:dartz/dartz.dart';

import 'repository.dart';
import '../../data/data_source/local_data_source.dart';
import '../../data/network/error_handler.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);
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
        return Left(ErrorHandler.handle(error).failure);
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
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(request);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.failure, response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Home>> getHome() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHome();
          if (response.status == ApiInternalStatus.success) {
            await _localDataSource.setHomeResponseToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(
                Failure(ApiInternalStatus.failure, response.message.orEmpty()));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    try {
      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getStoreDetails();
          if (response.status == ApiInternalStatus.success) {
            await _localDataSource.setStoreDetailsResponseToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(
                Failure(ApiInternalStatus.failure, response.message.orEmpty()));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
