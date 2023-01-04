// ignore: import_of_legacy_library_into_null_safe
import "package:shared_preferences/shared_preferences.dart";
import "package:tut_app/app/constants.dart";
import "package:tut_app/app/extension.dart";
import "package:tut_app/presentation/resources/language_manager.dart";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  Future<String> getAppLanguage() async {
    String lan =
        _sharedPreferences.getString(AppConstants.languageKey).orEmpty();
    if (lan.isNotEmpty) {
      return lan;
    } else {
      return LanguageType.english.getLanguage();
    }
  }

  bool isOnboardingViewed() =>
      _sharedPreferences.getBool(AppConstants.onBoardingView) ?? false;
  bool isLoggedInSuccessfully() =>
      _sharedPreferences.getBool(AppConstants.loginSuccessfully) ?? false;
  Future<void> setLoggedInSuccessfully() async {
    _sharedPreferences.setBool(AppConstants.loginSuccessfully, true);
  }

  Future<void> setOnboardingViewed() async {
    _sharedPreferences.setBool(AppConstants.onBoardingView, true);
  }
}
