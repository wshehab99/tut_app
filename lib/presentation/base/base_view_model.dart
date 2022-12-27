abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {}

abstract class BaseViewModelInputs {
  void init();
  void dispose();
}

abstract class BaseViewModelOutputs {}
