import "package:flutter/material.dart";
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

  Future<void> setLoggedOutSuccessfully() async {
    _sharedPreferences.remove(AppConstants.loginSuccessfully);
  }

  Future<void> changeAppLanguage() async {
    String language = await getAppLanguage();
    if (language == LanguageType.arabic.getLanguage()) {
      //set english
      await _sharedPreferences.setString(
          AppConstants.languageKey, LanguageType.english.getLanguage());
    } else {
      await _sharedPreferences.setString(
          AppConstants.languageKey, LanguageType.arabic.getLanguage());
    }
  }

  Future<Locale> getLocal() async {
    String language = await getAppLanguage();

    if (language == LanguageType.arabic.getLanguage()) {
      return LanguageType.arabic.getLocale();
    } else {
      return LanguageType.english.getLocale();
    }
  }
}
