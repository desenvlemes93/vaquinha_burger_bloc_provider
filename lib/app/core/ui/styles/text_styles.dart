import 'package:flutter/material.dart';

sealed class TextStyles {
  static String get font => 'mplus1';

  static TextStyle get textLight => TextStyle(
        fontWeight: FontWeight.w300,
        fontFamily: font,
      );
  static TextStyle get textRegular => TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: font,
      );
  static TextStyle get textMedium => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: font,
      );
  static TextStyle get textSemiBold => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: font,
      );
  static TextStyle get textBold => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: font,
      );
  static TextStyle get textExtraBold => TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: font,
      );

  static TextStyle get textButtonLabel => textBold.copyWith(
        fontSize: 14,
      );
  static TextStyle get textTile => textExtraBold.copyWith(fontSize: 28);
}
