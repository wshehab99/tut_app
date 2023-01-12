import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../domain/model/slider_object_model.dart';
import '../../resources/asset_manger.dart';
import '../../resources/string_manger.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderObjectView>();
  int currentIndex = 0;
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void init() {
    _pages = _getPages();
    _postDataToView();
  }

  @override
  int getNextPage() {
    int nextIndex = currentIndex + 1;
    if (nextIndex == _pages.length) {
      currentIndex = 0;
    } else {
      currentIndex = nextIndex;
    }
    return currentIndex;
  }

  void _postDataToView() {
    inputOnBoardingViewModel.add(SliderObjectView(
        sliderObject: _pages[currentIndex],
        numberOfSliders: _pages.length,
        currentIndex: currentIndex));
  }

  @override
  int getPreviousPage() {
    int previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      currentIndex = _pages.length - 1;
    } else {
      currentIndex = previousIndex;
    }
    return currentIndex;
  }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    _postDataToView();
  }

  late final List<SliderObject> _pages;
  List<SliderObject> _getPages() {
    return [
      SliderObject(
        title: StringManger.onBoardingTitle1.tr(),
        subTitle: StringManger.onBoardingSubTitle1.tr(),
        imagePath: ImageAsset.onboardingLogo1,
      ),
      SliderObject(
        title: StringManger.onBoardingTitle2.tr(),
        subTitle: StringManger.onBoardingSubTitle2.tr(),
        imagePath: ImageAsset.onboardingLogo2,
      ),
      SliderObject(
        title: StringManger.onBoardingTitle3.tr(),
        subTitle: StringManger.onBoardingSubTitle3.tr(),
        imagePath: ImageAsset.onboardingLogo3,
      ),
      SliderObject(
        title: StringManger.onBoardingTitle4.tr(),
        subTitle: StringManger.onBoardingSubTitle4.tr(),
        imagePath: ImageAsset.onboardingLogo4,
      ),
    ];
  }

  @override
  Sink get inputOnBoardingViewModel => _streamController.sink;

  @override
  Stream<SliderObjectView> get outputOnBoardingViewModel =>
      _streamController.stream.map((slideViewObject) => slideViewObject);
}

abstract class OnBoardingViewModelInputs {
  void onPageChanged(int index);
  int getNextPage();
  int getPreviousPage();
  Sink get inputOnBoardingViewModel;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderObjectView> get outputOnBoardingViewModel;
}
