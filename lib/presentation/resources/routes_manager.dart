import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view/forget_password_view.dart';
import 'package:tut_app/presentation/login/login_view/login_view.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/onboarding/onboarding_view/onboarding_view.dart';
import 'package:tut_app/presentation/register/register_view/register_view.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/store_details_view/store_details_view.dart';

class RoutesManager {
  static const String splashRoute = "/";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String onboardingRoute = "/onboarding";
  static const String forgetPasswordRoute = "/forgetPassword";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutesManager.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case RoutesManager.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case RoutesManager.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RoutesManager.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RoutesManager.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case RoutesManager.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      default:
        return _default();
    }
  }

  static Route<dynamic> _default() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  StringManger.noRouteFound,
                ).tr(),
              ),
              body: Center(
                  child: const Text(
                StringManger.noRouteFound,
              ).tr()),
            ));
  }
}
