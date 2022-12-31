enum LanguageType {
  english,
  arabic,
}

const String arabicLanguage = "ar";
const String englishLanguage = "en";

extension LanguageTypeExtension on LanguageType {
  String getLanguage() {
    switch (this) {
      case LanguageType.english:
        return englishLanguage;
      case LanguageType.arabic:
        return arabicLanguage;
    }
  }
}
