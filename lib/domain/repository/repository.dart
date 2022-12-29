import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/request.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest request);
}