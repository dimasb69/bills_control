import 'package:flutter/material.dart';

class AppThemes {
  // 1. Slate Theme (Blue-Grey, Opaque, Medium Dark)
  static final ThemeData slate = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // Medium-Dark Blue Grey Background
    scaffoldBackgroundColor: const Color(0xFF263238),
    primaryColor: const Color(0xFF607D8B), // Blue Grey
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFB0BEC5), // Light Blue Grey
      onPrimary: Color(0xFF263238),
      secondary: Color(0xFF78909C), // Muted Blue Grey
      onSecondary: Color(0xFFFFFFFF),
      surface: Color(0xFF37474F), // Slightly lighter Blue Grey surface
      onSurface: Color(0xFFCFD8DC), // Pale Blue Grey text
      error: Color(0xFFE57373),
      onError: Color(0xFF37474F),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF37474F),
      foregroundColor: Color(0xFFCFD8DC),
      elevation: 0,
    ),
    // cardTheme removed to fix type error;
  );

  // 2. Sage Theme (Green-Grey, Opaque, Medium Dark)
  static final ThemeData sage = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // Medium-Dark Green Grey Background
    scaffoldBackgroundColor: const Color(0xFF333D29),
    primaryColor: const Color(0xFF556B2F), // Dark Olive Green
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFA4AC86), // Sage Green
      onPrimary: Color(0xFF1F2416),
      secondary: Color(0xFFC2C5AA), // Pale Moss
      onSecondary: Color(0xFF333D29),
      surface: Color(0xFF414E34), // Lighter Green Grey surface
      onSurface: Color(0xFFE2E5DE), // Platinum/Grey text
      error: Color(0xFFE57373),
      onError: Color(0xFF414E34),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF414E34),
      foregroundColor: Color(0xFFE2E5DE),
      elevation: 0,
    ),
  );
}
