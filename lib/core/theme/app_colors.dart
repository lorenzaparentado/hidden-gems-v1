import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color forestGreen = Color(0xFF2D5A3D);
  static const Color sageGreen = Color(0xFF7BA05B);
  static const Color warmBeige = Color(0xFFF5F1E8);
  static const Color softCream = Color(0xFFFDFCF8);

  // Supporting Colors (Categories)
  static const Color dustyBlue = Color(0xFF5B7C99);  // Quiet category
  static const Color terracotta = Color(0xFFB5704D);  // Art category
  static const Color forestBrown = Color(0xFF6B4E3D); // Nature category
  static const Color goldenYellow = Color(0xFFD4A574); // Views category

  // Neutral Colors
  static const Color charcoal = Color(0xFF2C2C2C);
  static const Color mediumGray = Color(0xFF6B6B6B);
  static const Color lightGray = Color(0xFFE5E5E5);
  static const Color errorRed = Color(0xFFC85A54);

  // White
  static const Color white = Color(0xFFFFFFFF);

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'quiet':
        return dustyBlue;
      case 'art':
        return terracotta;
      case 'nature':
        return forestBrown;
      case 'views':
        return goldenYellow;
      default:
        return forestGreen;
    }
  }
}
