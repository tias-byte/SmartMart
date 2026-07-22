import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Color Tokens
  static const Color primary = Color(0xFF10B981); // Emerald Green
  static const Color secondary = Color(0xFF3B82F6); // Royal Blue
  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color danger = Color(0xFFEF4444); // Coral Red
  static const Color success = Color(0xFF10B981);

  // Background Tokens
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color bgDark = Color(0xFF0B0F17);
  static const Color cardDark = Color(0xFF111827);
  static const Color cardDarkElevated = Color(0xFF1E293B);

  // Borders
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF1E293B);
  static const Color borderDarkActive = Color(0xFF334155);

  // Light Theme
  static ThemeData lightTheme(BuildContext context) {
    final baseText = GoogleFonts.interTextTheme(ThemeData.light().textTheme);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgLight,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        tertiary: accent,
        error: danger,
        surface: Colors.white,
        onSurface: Color(0xFF0F172A),
      ),
      textTheme: baseText.copyWith(
        displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
        ),
        displayMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0F172A),
        ),
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0F172A),
        ),
        titleMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: const Color(0xFF0F172A),
        ),
        bodyLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: const Color(0xFF334155),
        ),
        bodyMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF0F172A),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderLight, width: 1),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme(BuildContext context) {
    final baseText = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        tertiary: accent,
        error: danger,
        surface: cardDark,
        onSurface: Color(0xFFF8FAFC),
      ),
      textTheme: baseText.copyWith(
        displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          color: const Color(0xFFF8FAFC),
        ),
        displayMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: const Color(0xFFF8FAFC),
        ),
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: const Color(0xFFF8FAFC),
        ),
        titleMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE2E8F0),
        ),
        bodyLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: const Color(0xFFCBD5E1),
        ),
        bodyMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: const Color(0xFF94A3B8),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: cardDark,
        foregroundColor: Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderDarkActive, width: 1),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardDarkElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E293B),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderDarkActive),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
      ),
    );
  }

  // Glassmorphism BoxDecoration helper
  static BoxDecoration glassCard({
    required bool isDark,
    double radius = 18,
    Color? accentBorderColor,
  }) {
    return BoxDecoration(
      color: isDark
          ? const Color(0xFF111827).withValues(alpha: 0.85)
          : Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: accentBorderColor ??
            (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.4)
              : const Color(0xFF64748B).withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
