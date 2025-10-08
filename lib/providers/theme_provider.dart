import 'package:flutter/material.dart';
import 'package:snd_aas/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isLight = true; // Start with light mode since your design is light-based
  bool get isLight => _isLight;

  ThemeData get currentTheme =>
      isLight ? _buildLightTheme() : _buildDarkTheme();

  ThemeData _buildLightTheme() {
    final ThemeData base = ThemeData.light();
    final textTheme = GoogleFonts.interTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: kSNDLightBg,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.light,
        background: kSNDLightBg,
        primary: kSNDPigmentGreen,
        onPrimary: Colors.white,
        secondary: kSNDJade,
        onSecondary: Colors.white,
        tertiary: kSNDYellowGreen,
        onTertiary: kSNDPigmentGreen400,
        error: kSNDError,
        onError: Colors.white,
        surface: kSNDLightBg2,
        onSurface: kSNDLightTextPrimary,
        surfaceContainerHighest: kSNDLightBg3,
        outline: kSNDLightBorder,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: kSNDLightBg,
        foregroundColor: kSNDLightTextPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: kSNDPigmentGreen,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        toolbarTextStyle: GoogleFonts.inter(
          color: kSNDLightTextSecondary,
          fontSize: 14,
        ),
        iconTheme: IconThemeData(color: kSNDJade),
        actionsIconTheme: IconThemeData(color: kSNDYellowGreen),
      ),
      cardTheme: CardThemeData(
        color: kSNDLightBg,
        elevation: 2,
        shadowColor: kSNDShadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: kSNDLightBorder, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kSNDPigmentGreen,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: kSNDShadowMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kSNDPigmentGreen,
          side: BorderSide(color: kSNDYellowGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kSNDLightBg,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDInputBorder, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDInputBorder, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDInputBorderFocus, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDError, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDError, width: 2),
        ),
        labelStyle: GoogleFonts.inter(
          color: kSNDJade,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: GoogleFonts.inter(
          color: kSNDWhite400,
        ),
        prefixIconColor: kSNDJade,
        suffixIconColor: kSNDWhite300,
      ),
      listTileTheme: ListTileThemeData(
        selectedTileColor: kSNDLightHover,
        selectedColor: kSNDPigmentGreen,
        textColor: kSNDLightTextSecondary,
        iconColor: kSNDLightTextSecondary,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        style: ListTileStyle.list,
      ),
      textTheme: textTheme.copyWith(
        // Display text (largest)
        displayLarge: textTheme.displayLarge?.copyWith(
          color: kSNDPigmentGreen,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: textTheme.displayMedium?.copyWith(
          color: kSNDPigmentGreen,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: textTheme.displaySmall?.copyWith(
          color: kSNDPigmentGreen,
          fontWeight: FontWeight.w600,
        ),

        // Headlines
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: kSNDPigmentGreen,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: kSNDPigmentGreen,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          color: kSNDJade,
          fontWeight: FontWeight.w600,
        ),

        // Titles
        titleLarge: textTheme.titleLarge?.copyWith(
          color: kSNDLightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: kSNDLightTextPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: textTheme.titleSmall?.copyWith(
          color: kSNDLightTextSecondary,
          fontWeight: FontWeight.w500,
        ),

        // Body text
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: kSNDLightTextPrimary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: kSNDWhite200,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          color: kSNDLightTextSecondary,
        ),

        // Labels
        labelLarge: textTheme.labelLarge?.copyWith(
          color: kSNDJade,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: textTheme.labelMedium?.copyWith(
          color: kSNDLightTextSecondary,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: textTheme.labelSmall?.copyWith(
          color: kSNDWhite300,
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    final textTheme = GoogleFonts.interTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: kSNDDarkBg,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.dark,
        background: kSNDDarkBg,
        primary: kSNDYellowGreen,
        onPrimary: kSNDDarkBg,
        secondary: kSNDJade,
        onSecondary: kSNDDarkBg,
        tertiary: kSNDCeladon,
        onTertiary: kSNDDarkBg,
        error: kSNDError,
        onError: Colors.white,
        surface: kSNDDarkBg2,
        onSurface: kSNDDarkTextPrimary,
        surfaceContainerHighest: kSNDDarkBg3,
        outline: kSNDDarkBorder,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: kSNDDarkBg2,
        foregroundColor: kSNDDarkTextPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          color: kSNDYellowGreen,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        toolbarTextStyle: GoogleFonts.inter(
          color: kSNDDarkTextSecondary,
          fontSize: 14,
        ),
        iconTheme: IconThemeData(color: kSNDYellowGreen),
        actionsIconTheme: IconThemeData(color: kSNDCeladon),
      ),
      cardTheme: CardThemeData(
        color: kSNDDarkBg2,
        elevation: 4,
        shadowColor: kSNDShadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: kSNDDarkBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kSNDYellowGreen,
          foregroundColor: kSNDDarkBg,
          elevation: 4,
          shadowColor: kSNDGlowYellowGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kSNDDarkTextPrimary,
          side: BorderSide(color: kSNDDarkBorder, width: 2),
          backgroundColor: kSNDDarkBg2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kSNDDarkBg2,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDDarkBorder, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDDarkBorder, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDYellowGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDError, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSNDError, width: 2),
        ),
        labelStyle: GoogleFonts.inter(
          color: kSNDDarkTextSecondary,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: GoogleFonts.inter(
          color: kSNDPigmentGreen400,
        ),
        prefixIconColor: kSNDDarkTextSecondary,
        suffixIconColor: kSNDPigmentGreen400,
      ),
      listTileTheme: ListTileThemeData(
        selectedTileColor: kSNDDarkHover,
        selectedColor: kSNDYellowGreen,
        textColor: kSNDDarkTextSecondary,
        iconColor: kSNDDarkTextSecondary,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        style: ListTileStyle.list,
      ),
      textTheme: textTheme.copyWith(
        // Display text (largest)
        displayLarge: textTheme.displayLarge?.copyWith(
          color: kSNDDarkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: textTheme.displayMedium?.copyWith(
          color: kSNDDarkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: textTheme.displaySmall?.copyWith(
          color: kSNDDarkTextPrimary,
          fontWeight: FontWeight.w600,
        ),

        // Headlines
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: kSNDYellowGreen,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: kSNDDarkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          color: kSNDDarkTextPrimary,
          fontWeight: FontWeight.w600,
        ),

        // Titles
        titleLarge: textTheme.titleLarge?.copyWith(
          color: kSNDDarkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: kSNDDarkTextPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: textTheme.titleSmall?.copyWith(
          color: kSNDDarkTextSecondary,
          fontWeight: FontWeight.w500,
        ),

        // Body text
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: kSNDDarkTextPrimary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: kSNDDarkTextPrimary,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          color: kSNDDarkTextSecondary,
        ),

        // Labels
        labelLarge: textTheme.labelLarge?.copyWith(
          color: kSNDDarkTextSecondary,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: textTheme.labelMedium?.copyWith(
          color: kSNDDarkTextSecondary,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: textTheme.labelSmall?.copyWith(
          color: kSNDPigmentGreen400,
        ),
      ),
    );
  }

  void toggleTheme() {
    _isLight = !_isLight;
    notifyListeners();
  }
}
