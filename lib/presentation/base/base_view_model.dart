import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _stateStreamController = BehaviorSubject<FlowState>();
  @override
  void dispose() {
    _stateStreamController.close();
  }

  @override
  Sink get inputState => _stateStreamController.sink;
  @override
  Stream<FlowState> get outputState =>
      _stateStreamController.stream.map((state) => state);
}

abstract class BaseViewModelInputs {
  void init();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
