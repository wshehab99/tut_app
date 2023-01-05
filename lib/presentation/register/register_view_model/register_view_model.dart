import 'dart:async';

import 'package:tut_app/data/network/request.dart';
import 'package:tut_app/domain/use_case/register_use_case.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data_classes/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../app/app_functions.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController<String> _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController<String> _phoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _profilePhotoStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _validateInputStreamController =
      StreamController<void>.broadcast();
  final RegisterObject _registerObject = RegisterObject("", "", "", "", "");
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);
  @override
  void init() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _phoneNumberStreamController.close();
    _profilePhotoStreamController.close();
    _validateInputStreamController.close();

    super.dispose();
  }

//inputs
  @override
  Sink get username => _usernameStreamController.sink;
  @override
  Sink get email => _emailStreamController.sink;

  @override
  Sink get password => _passwordStreamController.sink;

  @override
  Sink get phoneNumber => _phoneNumberStreamController.sink;

  @override
  Sink get profilePhoto => _profilePhotoStreamController.sink;

  @override
  setEmail(String value) {
    email.add(value);
    _registerObject.copyWith(email: value);
    inputAreAllInputValid.add(null);
  }

  @override
  setPassword(String value) {
    password.add(value);
    _registerObject.copyWith(password: value);

    inputAreAllInputValid.add(null);
  }

  @override
  setPhoneNumber(String value) {
    phoneNumber.add(value);
    _registerObject.copyWith(phone: value);

    inputAreAllInputValid.add(null);
  }

  @override
  setProfilePhoto(String value) {
    profilePhoto.add(value);
    _registerObject.copyWith(profileImage: value);

    inputAreAllInputValid.add(null);
  }

  @override
  setUsername(String value) {
    _registerObject.copyWith(username: value);

    username.add(value);
    inputAreAllInputValid.add(null);
  }

  @override
  register() {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.loadingPopupState));
    _registerUseCase.execute(RegisterRequest(
        _registerObject.username,
        _registerObject.email,
        _registerObject.password,
        _registerObject.phone,
        _registerObject.profileImage));
  }

  //outputs

  @override
  Stream<bool> get isEmailValid => _emailStreamController.stream
      .map((email) => AppFunctions.checkEmailValidity(email));

  @override
  Stream<bool> get isPasswordValid => _passwordStreamController.stream
      .map((password) => _validatePassword(password));

  @override
  Stream<bool> get isPhoneNumberValid => _phoneNumberStreamController.stream
      .map((phoneNumber) => _validatePhoneNumber(phoneNumber));

  @override
  Stream<bool> get isProfilePhotoValid => _profilePhotoStreamController.stream
      .map((profilePhoto) => _validateUsername(profilePhoto));

  @override
  Stream<bool> get isUserNameValid => _usernameStreamController.stream
      .map((userName) => _validateUsername(userName));

  @override
  Sink get inputAreAllInputValid => _validateInputStreamController.sink;

  @override
  Stream<bool> get outputAreAllInputValid =>
      _validateInputStreamController.stream.map((_) => _validate());
  bool _validate() =>
      AppFunctions.checkEmailValidity(_registerObject.email) &&
      _validateUsername(_registerObject.username) &&
      _validatePassword(_registerObject.password) &&
      _validatePhoneNumber(_registerObject.phone) &&
      _validateUsername(_registerObject.profileImage);
  bool _validateUsername(String username) => username.isNotEmpty;
  bool _validatePassword(String password) => password.length >= 6;
  bool _validatePhoneNumber(String phoneNumber) => phoneNumber.length >= 10;
}

abstract class RegisterViewModelInputs {
  Sink get username;

  Sink get email;
  Sink get password;
  Sink get phoneNumber;
  Sink get profilePhoto;
  Sink get inputAreAllInputValid;
  setUsername(String value);
  setPassword(String value);
  setPhoneNumber(String value);
  setProfilePhoto(String value);
  setEmail(String value);
  register();
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get isUserNameValid;
  Stream<bool> get isEmailValid;
  Stream<bool> get isPasswordValid;
  Stream<bool> get isPhoneNumberValid;
  Stream<bool> get isProfilePhotoValid;
  Stream<bool> get outputAreAllInputValid;
}
