import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:notes_app/res/extensions/color_extsion.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData light = ThemeData(
    useMaterial3: false,
    canvasColor: ThemeData().colorScheme.primarytheme,
    dialogTheme: DialogThemeData(
      backgroundColor: ThemeData().colorScheme.primarytheme,
    ),
    iconTheme: ThemeData().iconTheme.copyWith(color: ColorExtsion.secondary),
    textTheme: GoogleFonts.robotoMonoTextTheme(),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: false,
    canvasColor: ThemeData().colorScheme.primarytheme,
    dialogTheme: DialogThemeData(
      backgroundColor: ThemeData().colorScheme.primarytheme,
    ),
    iconTheme: ThemeData().iconTheme.copyWith(color: ColorExtsion.secondary),
    textTheme: GoogleFonts.robotoMonoTextTheme(),
  );
}
