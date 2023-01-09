import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/base_use_case.dart';

import '../../data/network/failure.dart';

class HomeUseCase implements BaseUseCase<void, Home> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, Home>> execute(void input) async {
    return _repository.getHome();
  }
}
