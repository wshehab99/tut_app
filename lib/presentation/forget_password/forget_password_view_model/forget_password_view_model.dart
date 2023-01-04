import 'dart:async';
import 'package:tut_app/data/network/request.dart';
import 'package:tut_app/domain/use_case/login_use_case.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

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
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => _checkValidity(email));
  bool _checkValidity(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

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
      inputState.add(ContentState());
    });
  }

  @override
  Sink get inputAreAllInputIsValid => _areAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputAreAllInputIsValid =>
      _areAllInputValidStreamController.stream
          .map((_) => _checkValidity(_email));
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
