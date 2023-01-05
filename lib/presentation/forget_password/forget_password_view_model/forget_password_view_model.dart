import 'dart:async';
import 'package:tut_app/app/app_functions.dart';
import 'package:tut_app/data/network/request.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../domain/use_case/forget_password_use_case.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordInputs, ForgetPasswordOutputs {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputValidStreamController =
      StreamController<void>.broadcast();
  String _email = "";
  @override
  Sink get email => _emailStreamController.sink;

  @override
  void init() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _areAllInputValidStreamController.close();
    super.dispose();
  }

  @override
  Stream<bool> get isEmailValid => _emailStreamController.stream
      .map((email) => AppFunctions.checkEmailValidity(email));

  @override
  setEmail(String value) {
    email.add(value);
    inputAreAllInputIsValid.add(null);
    _email = value;
  }

  @override
  forgetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.loadingPopupState));
    (await _forgetPasswordUseCase.execute(ForgetPasswordRequest(_email))).fold(
        (failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.errorPopupState,
          message: failure.message));
    }, (forgetPasswordModel) {
      inputState.add(SuccessState(
          stateRendererType: StateRendererType.successPopupState,
          message: forgetPasswordModel.message));
    });
  }

  @override
  Sink get inputAreAllInputIsValid => _areAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputAreAllInputIsValid =>
      _areAllInputValidStreamController.stream
          .map((_) => AppFunctions.checkEmailValidity(_email));
}

abstract class ForgetPasswordInputs {
  Sink get email;
  Sink get inputAreAllInputIsValid;
  setEmail(String value);

  forgetPassword();
}

abstract class ForgetPasswordOutputs {
  Stream<bool> get isEmailValid;
  Stream<bool> get outputAreAllInputIsValid;
}
