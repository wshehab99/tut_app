import 'package:flutter/material.dart';
import 'package:tut_app/app/app_preferences.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';

import '../presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: RoutesManager.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: ThemeManager.applicationTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
