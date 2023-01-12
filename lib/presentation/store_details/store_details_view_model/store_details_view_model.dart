import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';
import 'package:tut_app/domain/use_case/store_details_use_case.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../base/base_view_model.dart';
import '../../common/state_renderer/state_renderer.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final StoreDetailsUseCase _storeDetailsUseCase;
  StoreDetailsViewModel(this._storeDetailsUseCase);
  final StreamController<StoreDetails> _storeDetailsStreamController =
      BehaviorSubject<StoreDetails>();
  @override
  void init() {
    getStoreDetails();
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((store) => store);

  @override
  getStoreDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.loadingFullScreenState));
    (await _storeDetailsUseCase.execute(null)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.errorFullScreenState,
          message: failure.message));
    }, (storeDetails) {
      inputStoreDetails.add(storeDetails);
      inputState.add(ContentState());
    });
  }
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
  getStoreDetails();
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
