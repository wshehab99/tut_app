import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view.dart';
import 'package:tut_app/presentation/login/login_view.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/register/register_view.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/store_details_view.dart';

class RoutesManager {
  static const String splashRoute = "/";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutesManager.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case RoutesManager.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case RoutesManager.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RoutesManager.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RoutesManager.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      default:
        return _default();
    }
  }

  static Route<dynamic> _default() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("No Route Found"),
              ),
              body: const Center(child: Text("No Route Found")),
            ));
  }
}
