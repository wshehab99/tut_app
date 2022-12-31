import 'dart:async';

import 'package:tut_app/domain/use_case/login_use_case.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';

import '../../../data/network/request.dart';
import '../../base/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final LoginObject loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
  }

  @override
  void init() {
    // TODO: implement init
  }

// inputs
  @override
  login() {
    _loginUseCase
        .execute(LoginRequest(loginObject.userName, loginObject.password));
  }

  @override
  Sink get userName => _userNameStreamController.sink;
  @override
  Sink get password => _passwordStreamController.sink;

  @override
  setPassword(String value) {
    password.add(value);
    loginObject.copyWith(password: value);
  }

  @override
  setUserName(String value) {
    userName.add(value);
    loginObject.copyWith(userName: value);
  }

  //outputs
  @override
  Stream<bool> get isPasswordValid => _passwordStreamController.stream
      .map((password) => _isFieldValid(password));

  @override
  Stream<bool> get isUserNameValid => _userNameStreamController.stream
      .map((userName) => _isFieldValid(userName));

  bool _isFieldValid(String field) {
    return field.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  login();
  setUserName(String value);

  setPassword(String value);
  Sink get userName;
  Sink get password;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get isUserNameValid;

  Stream<bool> get isPasswordValid;
}