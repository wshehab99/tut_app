import 'package:tut_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/request.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginRequest, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginRequest input) async {
    return await _repository.login(input);
  }
}
