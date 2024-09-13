import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _defaultPrimaryColor = Color(0xFF9BD1EB);

  static ThemeData _createTheme(Color primaryColor, Brightness brightness) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _defaultPrimaryColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      textTheme: GoogleFonts.fredokaTextTheme(
        brightness == Brightness.light
            ? ThemeData.light().textTheme
            : ThemeData.dark().textTheme,
      ),
    );
  }

  static ThemeData light({Color primaryColor = _defaultPrimaryColor}) {
    return _createTheme(primaryColor, Brightness.light);
  }

  static ThemeData dark({Color primaryColor = _defaultPrimaryColor}) {
    return _createTheme(primaryColor, Brightness.dark);
  }
}

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = AppTheme._defaultPrimaryColor;

  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}
