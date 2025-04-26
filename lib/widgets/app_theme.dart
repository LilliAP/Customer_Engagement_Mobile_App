import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static final ColorScheme appColorScheme = ColorScheme.fromSeed(
    seedColor: Color(0xff825A3C),
    primary: Color(0xff84634a),
    secondary: Color(0xff825A3C),
    surface: Color(0xffF7EBDF),
    onPrimary: Color(0xff372414),
    onSecondary: Color(0xff372414),
    onSurface: Color(0xff372414)
  );
  static final ThemeData appThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: appColorScheme,
    textTheme: GoogleFonts.heptaSlabTextTheme(),
  );
}
