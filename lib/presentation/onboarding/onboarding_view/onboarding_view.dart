import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tut_app/presentation/onboarding/onboarding_view_model/onboarding_view_model.dart';
import 'package:tut_app/presentation/resources/asset_manger.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import '../../../app/app_preferences.dart';
import '../../../app/di.dart';
import '../../../domain/model/slider_object_model.dart';
import '../../resources/constants_manager.dart';
import '../../resources/value_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();
  final OnBoardingViewModel _model = OnBoardingViewModel();
  final AppPreferences _appPref = instance<AppPreferences>();

  @override
  void initState() {
    _model.init();
    _appPref.setOnboardingViewed();
    super.initState();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderObjectView>(
        stream: _model.outputOnBoardingViewModel,
        builder: (context, snapshots) {
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              elevation: SizeValuesManager.s0,
              backgroundColor: ColorManager.white,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: ColorManager.white,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: snapshots.data == null
                ? Container()
                : PageView.builder(
                    onPageChanged: (value) {
                      _model.onPageChanged(value);
                    },
                    itemBuilder: (context, index) {
                      return OnBoardingPage(
                        sliderObject: snapshots.data!.sliderObject,
                      );
                    },
                    controller: _controller,
                    itemCount: snapshots.data!.numberOfSliders,
                  ),
            bottomSheet: snapshots.data == null
                ? Container()
                : Container(
                    color: ColorManager.white,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          child: Text(
                            StringManger.skip.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RoutesManager.loginRoute);
                          },
                        ),
                      ),
                      _getBottomSheetIndicator(snapshots.data!),
                    ]),
                  ),
          );
        });
  }

  Widget _getBottomSheetIndicator(SliderObjectView slider) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _controller.animateToPage(_model.getPreviousPage(),
                  duration:
                      const Duration(milliseconds: ConstantsManager.pageDelay),
                  curve: Curves.bounceInOut);
            },
            icon: SvgPicture.asset(
              ImageAsset.leftArrowIc,
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < slider.numberOfSliders; i++)
                Padding(
                  padding: const EdgeInsets.all(PaddingValuesManager.p8),
                  child: _getProperCircle(i, slider.currentIndex),
                )
            ],
          ),
          IconButton(
            onPressed: () {
              _controller.animateToPage(_model.getNextPage(),
                  duration:
                      const Duration(milliseconds: ConstantsManager.pageDelay),
                  curve: Curves.bounceInOut);
            },
            icon: SvgPicture.asset(
              ImageAsset.rightArrowIc,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    return SvgPicture.asset(index == currentIndex
        ? ImageAsset.hollowCircleIc
        : ImageAsset.solidCircleIc);
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.sliderObject,
  });
  final SliderObject sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: SizeValuesManager.s10,
        ),
        Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: SizeValuesManager.s10,
        ),
        SvgPicture.asset(sliderObject.imagePath),
      ],
    );
  }
}
