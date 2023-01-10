import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/slider_object_model.dart';
import 'package:tut_app/domain/use_case/home_use_case.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Services>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();
  final HomeUseCase _useCase;
  HomeViewModel(this._useCase);
  // inputs
  @override
  void init() {
    getHomeData();
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _storesStreamController.close();
    _servicesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // outputs
  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banner) => banner);

  @override
  Stream<List<Services>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
  Future<void> getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.loadingFullScreenState));
    (await _useCase.execute(null)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.errorFullScreenState,
          message: failure.message));
    }, (home) {
      inputBanners.add(home.data.banners);
      inputServices.add(home.data.services);
      inputStores.add(home.data.stores);

      inputState.add(ContentState());
    });
  }
}

abstract class HomeViewModelInput {
  Sink get inputBanners;
  Sink get inputServices;
  Sink get inputStores;
}

abstract class HomeViewModelOutput {
  Stream<List<BannerAd>> get outputBanners;
  Stream<List<Services>> get outputServices;
  Stream<List<Store>> get outputStores;
}
