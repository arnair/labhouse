import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFFC5A059);
  static const Color primaryLight = Color(0xFFFFD587);

  // Secondary Colors
  static const Color secondary = Color(0xFF2D3436);
  static const Color secondaryLight = Color(0xFF4A5558);

  // Status Colors
  static const Color warning = Color(0xFFFF9F43);
  static const Color error = Color(0xFFFF6B6B);

  // Medal Colors
  static const Color gold = Color(0xFFF1C40F);
  static const Color silver = Color(0xFFAAAAAA);
  static const Color bronze = Color(0xFFCD7F32);

  // Surface Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE9ECEF);

  // Text Colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textTertiary = Color(0xFFB2BEC3);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color(0xFFE8F0FE), // Noticeable blue top
      Color(0xFFF3E8FF), // Visible lavender middle
      Color(0xFFFFE8F0), // Soft pink bottom
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFED8A), gold, Color(0xFFDAA520)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient silverGradient = LinearGradient(
    colors: [Color(0xFFF5F5F5), silver, Color(0xFF7F7F7F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bronzeGradient = LinearGradient(
    colors: [Color(0xFFE6BA95), bronze, Color(0xFF8B4513)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Get rank color for an item
  static Color getRankColor(int rank) {
    switch (rank) {
      case 1:
        return gold;
      case 2:
        return silver;
      case 3:
        return bronze;
      default:
        return primary;
    }
  }
}
