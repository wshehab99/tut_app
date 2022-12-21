import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tut',
      initialRoute: RoutesManager.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      theme: ThemeManager.applicationTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
