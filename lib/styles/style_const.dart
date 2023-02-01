import 'package:flutter/material.dart';
import 'package:zagel/styles/colors.dart';
import 'package:zagel/styles/string_const.dart';

class AppStyleConstants {
  static TextStyle textStyle({
    double? size = 35,
    FontWeight? fontWeight = FontWeight.w600,
    Color? colr = AppColorsConstants.conAppNameColor,
    bool? isunderLine = false,
  }) {
    return TextStyle(
      color: colr,
      fontFamily: AppStringsConstants.fontFamily,
      fontWeight: fontWeight,
      fontSize: size,
      decoration: isunderLine! ? TextDecoration.underline : TextDecoration.none,
      decorationColor: AppColorsConstants.conAppNameColor,
    );
  }
}
