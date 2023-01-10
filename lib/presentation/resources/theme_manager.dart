import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'input_border_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';

class ThemeManager {
  static ThemeData applicationTheme() {
    return ThemeData(
      //dialog theme
      dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeValuesManager.s14),
          ),
          elevation: SizeValuesManager.s1,
          backgroundColor: ColorManager.transparent),
      scaffoldBackgroundColor: ColorManager.white,

      // main colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,

      // cardView theme
      cardTheme: const CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: SizeValuesManager.s4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeValuesManager.s10),
          ),
        ),
      ),
      // app bar theme
      appBarTheme: AppBarTheme(
        color: ColorManager.primary,
        elevation: SizeValuesManager.s4,
        shadowColor: ColorManager.lightPrimary,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkPrimary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark),
        centerTitle: true,
        titleTextStyle: StyleManager.getRegularStyle(
          fontSize: FontSizeManager.s16,
          color: ColorManager.white,
        ),
      ),
      // button theme
      buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary,
      ),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              StyleManager.getRegularStyle(
                color: ColorManager.white,
                fontSize: FontSizeManager.s17,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color?>(
              ColorManager.primary,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SizeValuesManager.s12,
                ),
              ),
            )),
      ),
      // text theme
      textTheme: TextTheme(
        headlineLarge: StyleManager.getSemiBoldStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSizeManager.s16,
        ),
        headlineMedium: StyleManager.getRegularStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSizeManager.s14,
        ),
        titleMedium: StyleManager.getMediumStyle(
          color: ColorManager.primary,
          fontSize: FontSizeManager.s16,
        ),
        labelLarge: StyleManager.getRegularStyle(
          color: ColorManager.grey1,
          fontSize: FontSizeManager.s12,
        ),
        headlineSmall: StyleManager.getBoldStyle(
          color: ColorManager.primary,
          fontSize: FontSizeManager.s14,
        ),
        bodyLarge: StyleManager.getRegularStyle(
          color: ColorManager.grey,
          fontSize: FontSizeManager.s12,
        ),
        bodyMedium: StyleManager.getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSizeManager.s18,
        ),
        displayLarge: StyleManager.getSemiBoldStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSizeManager.s16,
        ),
        titleSmall: StyleManager.getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSizeManager.s16,
        ),
        displaySmall: StyleManager.getRegularStyle(
          color: ColorManager.grey2,
          fontSize: FontSizeManager.s14,
        ),
      ),
      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(PaddingValuesManager.p8),
        // hint style
        hintStyle: StyleManager.getRegularStyle(
            color: ColorManager.grey, fontSize: FontSizeManager.s14),
        labelStyle: StyleManager.getMediumStyle(
            color: ColorManager.grey, fontSize: FontSizeManager.s14),
        errorStyle: StyleManager.getRegularStyle(color: ColorManager.error),

        // enabled border style
        enabledBorder: InputBorderManager.getInputBorder(
          color: ColorManager.grey,
        ),
        // focused border style
        focusedBorder: InputBorderManager.getInputBorder(
          color: ColorManager.primary,
        ),

        // error border style
        errorBorder: InputBorderManager.getInputBorder(
          color: ColorManager.error,
        ),
        // focused border style
        focusedErrorBorder: InputBorderManager.getInputBorder(
          color: ColorManager.primary,
        ),
      ),
      //NavigationBar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.lightGrey,
        elevation: SizeValuesManager.s10,
      ),
    );
  }
}
