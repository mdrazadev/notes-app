import 'package:flutter/material.dart';

extension ColorExtsion on ColorScheme {
  static const Color primary = Color(0xffF8F4EE);
  static const Color darkPrimary = Color(0xffF8F4EE);

  static const Color secondary = Color(0xffffffff);
  static const Color darkSecondary = Color(0xffffffff);

  static const Color black = Color(0xff131313);
  static const Color darkBlac = Color(0xff131313);

  Color get primarytheme =>
      brightness == Brightness.dark ? darkPrimary : primary;

  Color get secondarytheme =>
      brightness == Brightness.dark ? darkSecondary : secondary;

  Color get blacktheme => brightness == Brightness.dark ? darkBlac : black;
}
