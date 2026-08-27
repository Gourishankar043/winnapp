import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand / design tokens
  static const Color accent = Color(0xFFEA5B0C);
  static const Color ink = Color(0xFF211E18);
  static const Color surfaceMuted = Color(0xFFE9E2D2);

  static const Color success = Color(0xFF2F8F4E);
  static const Color warning = Color(0xFFC98A0D);
  static const Color danger = Color(0xFFB83D30);

  // Semantic aliases used by Flutter ThemeData
  static const Color primary = accent;
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Light theme
  static const Color lightBackground = Color(0xFFFAF8F2);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = ink;
  static const Color lightMutedText = Color(0xFF6B6257);
  static const Color lightBorder = Color(0xFFD8CCB6);

  // Dark theme
  static const Color darkBackground = Color(0xFF171613);
  static const Color darkSurface = Color(0xFF24221E);
  static const Color darkText = Color(0xFFF5F1E8);
  static const Color darkMutedText = Color(0xFFC9C1B3);
  static const Color darkBorder = Color(0xFF4B463D);

  // Semantic error alias
  static const Color error = danger;

  // Optional informational state
  static const Color info = Color(0xFF527A91);
}