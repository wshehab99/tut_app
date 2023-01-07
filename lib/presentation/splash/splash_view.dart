import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/asset_manger.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';

import '../../app/app_preferences.dart';
import '../../app/di.dart';
import '../resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPref = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(
        const Duration(
          seconds: ConstantsManager.splashDelay,
        ),
        _goNext);
  }

  _goNext() {
    if (_appPref.isLoggedInSuccessfully()) {
      Navigator.pushReplacementNamed(context, RoutesManager.mainRoute);
    } else if (_appPref.isOnboardingViewed()) {
      Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RoutesManager.onboardingRoute);
    }
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
          child: Image.asset(
        ImageAsset.splashLogo,
      )),
    );
  }
}
