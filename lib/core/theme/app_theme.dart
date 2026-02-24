import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AxleColors.accent,
      secondary: AxleColors.accentDark,
      surface: AxleColors.bgCard,
      error: AxleColors.critical,
    );

    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AxleColors.bg,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AxleColors.bg,
        foregroundColor: AxleColors.textPrimary,
        centerTitle: false,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: AxleColors.textPrimary,
          letterSpacing: -1,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AxleColors.textPrimary,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AxleColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          color: AxleColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          color: AxleColors.textSecondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AxleColors.bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AxleRadius.xl),
          side: const BorderSide(color: AxleColors.borderCard),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AxleColors.bgElevated,
        hintStyle: const TextStyle(color: AxleColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AxleRadius.lg),
          borderSide: const BorderSide(color: AxleColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AxleRadius.lg),
          borderSide: const BorderSide(color: AxleColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AxleRadius.lg),
          borderSide:
              const BorderSide(color: AxleColors.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AxleRadius.lg),
          borderSide: const BorderSide(color: AxleColors.critical),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AxleColors.bg,
          backgroundColor: AxleColors.accent,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AxleRadius.lg),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AxleColors.textSecondary,
          side: const BorderSide(color: AxleColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AxleRadius.lg),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AxleColors.bgElevated,
        contentTextStyle: const TextStyle(color: AxleColors.textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AxleRadius.md),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: const DividerThemeData(
        color: AxleColors.border,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AxleColors.bgElevated,
        selectedColor: AxleColors.accentDim,
        labelStyle: const TextStyle(
          color: AxleColors.textSecondary,
          fontSize: 12,
        ),
        side: const BorderSide(color: AxleColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AxleRadius.pill),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AxleColors.bgCard),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AxleRadius.lg),
              side: const BorderSide(color: AxleColors.border),
            ),
          ),
        ),
      ),
    );
  }
}
