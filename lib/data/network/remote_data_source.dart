import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/request.dart';
import 'package:tut_app/data/response/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest request);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServicesClient _appServicesClient;
  RemoteDataSourceImpl(this._appServicesClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest request) async {
    return await _appServicesClient.login(request.email, request.password);
  }
}
