import 'package:flutter/material.dart';
import 'package:tut_app/presentation/font_manger.dart';

class StyleManger {
  static TextStyle _getStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: FontFamilyManager.fontFamily,
    );
  }

  static TextStyle getBoldStyle({
    double fontSize = FontSizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.bold,
    );
  }

  static TextStyle getSemiBoldStyle({
    double fontSize = FontSizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.semiBold,
    );
  }

  static TextStyle getMediumStyle({
    double fontSize = FontSizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.medium,
    );
  }

  static TextStyle getRegularStyle({
    double fontSize = FontSizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.regular,
    );
  }

  static TextStyle getLightStyle({
    double fontSize = FontSizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.light,
    );
  }
}
