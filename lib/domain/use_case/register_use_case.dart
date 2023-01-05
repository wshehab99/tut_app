import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/request.dart';
import '../model/slider_object_model.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class RegisterUseCase implements BaseUseCase<RegisterRequest, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterRequest input) async {
    return await _repository.register(input);
  }
}
