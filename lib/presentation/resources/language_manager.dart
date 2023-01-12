import 'package:flutter/material.dart';

enum LanguageType {
  english,
  arabic,
}

const String arabicLanguage = "ar";
const String englishLanguage = "en";
const String transAssets = "assets/translations";

extension LanguageTypeExtension on LanguageType {
  String getLanguage() {
    switch (this) {
      case LanguageType.english:
        return englishLanguage;
      case LanguageType.arabic:
        return arabicLanguage;
    }
  }

  Locale getLocale() {
    switch (this) {
      case LanguageType.english:
        return const Locale(englishLanguage, "US");
      case LanguageType.arabic:
        return const Locale(arabicLanguage, "SA");
    }
  }
}
