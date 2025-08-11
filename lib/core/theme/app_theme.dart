import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Create consistent text styles using system fonts
  static TextStyle _textStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamilyFallback: const [
        'Roboto',
        'Arial',
        'Helvetica',
        'sans-serif',
        'Noto Sans',
        'Noto Color Emoji',
      ],
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: _createMaterialColor(AppColors.forestGreen),
      primaryColor: AppColors.forestGreen,
      scaffoldBackgroundColor: AppColors.softCream,
      fontFamilyFallback: const [
        'Roboto',
        'Arial',
        'Helvetica',
        'sans-serif',
        'Noto Sans',
        'Noto Color Emoji',
      ],
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.softCream,
        foregroundColor: AppColors.charcoal,
        elevation: 0,
        titleTextStyle: _textStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.charcoal,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: _textStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.charcoal,
        ),
        headlineMedium: _textStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.charcoal,
        ),
        headlineSmall: _textStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.charcoal,
        ),
        bodyLarge: _textStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.charcoal,
        ),
        bodyMedium: _textStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.charcoal,
        ),
        bodySmall: _textStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.mediumGray,
        ),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: _textStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.forestGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.errorRed),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.warmBeige,
        elevation: 2,
        shadowColor: AppColors.charcoal.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.charcoal,
        size: 24,
      ),
    );
  }

  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

// Spacing constants following the 16px base unit system
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

// Border radius constants
class AppRadius {
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
}
