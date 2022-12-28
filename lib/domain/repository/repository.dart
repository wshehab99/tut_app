import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/request.dart';
import 'package:tut_app/data/response/response.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationResponse>> login(LoginRequest request);
}
