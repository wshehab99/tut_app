import 'dart:async';

import 'package:tut_app/app/constants.dart';
import 'package:tut_app/domain/use_case/login_use_case.dart';
import 'package:tut_app/presentation/common/freezed_data_classes/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';

import '../../../data/network/request.dart';
import '../../base/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValid =
      StreamController<void>.broadcast();
  LoginObject loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
    super.dispose();
    _passwordStreamController.close();
    _userNameStreamController.close();
    _areAllInputsValid.close();
  }

  @override
  void init() {
    inputState.add(ContentState());
  }

// inputs
  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.loadingPopupState));
    (await _loginUseCase
            .execute(LoginRequest(loginObject.username, loginObject.password)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      stateRendererType: StateRendererType.errorPopupState,
                      message: failure.message))
                },
            (auth) => {inputState.add(ContentState())});
  }

  @override
  Sink get userName => _userNameStreamController.sink;
  @override
  Sink get password => _passwordStreamController.sink;

  @override
  setPassword(String value) {
    password.add(value);
    loginObject = LoginObject(loginObject.username, value);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String value) {
    userName.add(value);
    loginObject = LoginObject(value, loginObject.password);

    inputAreAllInputsValid.add(null);
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValid.sink;

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

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValid.stream.map((_) => _checkValidation());
  bool _checkValidation() =>
      _isFieldValid(loginObject.username) &&
      _isFieldValid(loginObject.password);
}

abstract class LoginViewModelInputs {
  login();
  setUserName(String value);

  setPassword(String value);
  Sink get userName;
  Sink get password;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get isUserNameValid;

  Stream<bool> get isPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
