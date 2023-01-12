import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/presentation/resources/language_manager.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: [
      LanguageType.english.getLocale(),
      LanguageType.arabic.getLocale(),
    ],
    path: transAssets,
    child: Phoenix(child: const MyApp()),
  ));
}
