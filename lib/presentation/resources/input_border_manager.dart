import 'package:flutter/material.dart';

import 'value_manager.dart';

class InputBorderManager {
  static getInputBorder({required Color color}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: SizeValuesManager.s1),
        borderRadius:
            const BorderRadius.all(Radius.circular(SizeValuesManager.s8)));
  }
}
