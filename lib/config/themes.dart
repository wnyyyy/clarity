import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color appPrimaryColor = Color(0xFF9BD1EB);
  static const Color appSecondaryColor = Color(0xFFF6F4F5);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: appPrimaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: appPrimaryColor,
      foregroundColor: appSecondaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: appPrimaryColor,
      foregroundColor: appSecondaryColor,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(ThemeData.light().textTheme),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: appPrimaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appPrimaryColor.withOpacity(0.2),
      foregroundColor: appSecondaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: appPrimaryColor,
      foregroundColor: appSecondaryColor,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(ThemeData.dark().textTheme),
  );
}
