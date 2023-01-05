import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/request.dart';
import '../model/slider_object_model.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<ForgetPasswordRequest, ForgetPasswordModel> {
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgetPasswordModel>> execute(
      ForgetPasswordRequest input) async {
    return await _repository.forgetPassword(input);
  }
}
