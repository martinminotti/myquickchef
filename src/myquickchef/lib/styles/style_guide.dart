import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme buildTextTheme() {
  return TextTheme(
    titleLarge: GoogleFonts.inter(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      height: 22 / 32,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 27.0,
      fontWeight: FontWeight.bold,
      height: 17 / 27,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      height: 15 / 25,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 27.0,
      fontWeight: FontWeight.w500,
      height: 17 / 27,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.1,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 12 / 15,
    ),
  );
}

ColorScheme buildColorSchemeTheme() {
  return const ColorScheme(
    primary: Color(0xFF01BAEF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFF747A96),
    onSecondary: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF1B2536),
    error: Color(0xFFFF6464),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF747A96),
    brightness: Brightness.light,
  );
}
