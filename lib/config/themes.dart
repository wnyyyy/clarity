import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _appPrimaryColor = Color(0xFF9BD1EB);
  static const Color _appSecondaryColor = Color(0xFFF6F4F5);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _appPrimaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _appPrimaryColor,
      foregroundColor: _appSecondaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _appPrimaryColor,
      foregroundColor: _appSecondaryColor,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(ThemeData.light().textTheme),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _appPrimaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _appPrimaryColor.withOpacity(0.2),
      foregroundColor: _appSecondaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _appPrimaryColor,
      foregroundColor: _appSecondaryColor,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(ThemeData.dark().textTheme),
  );
}
