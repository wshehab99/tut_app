import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/presentation/resources/asset_manger.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';

import '../resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(
        const Duration(
          seconds: ConstantsManager.splashDelay,
        ),
        _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, RoutesManager.onboardingRoute);
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
      appBar: AppBar(
          toolbarHeight: 0,
          elevation: SizeValuesManager.s0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: ColorManager.primary)),
      body: Center(
          child: Image.asset(
        ImageAsset.splashLogo,
      )),
    );
  }
}
