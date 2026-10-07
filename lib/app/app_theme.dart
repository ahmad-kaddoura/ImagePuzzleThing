import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const ink = Color(0xFF253D39);
  static const teal = Color(0xFF24786C);
  static const paper = Color(0xFFF7F5EF);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: paper,
    colorScheme: ColorScheme.fromSeed(seedColor: teal, surface: paper),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: ink,
        letterSpacing: -1.5,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: ink,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: ink),
    ),
  );
}
