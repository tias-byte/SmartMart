import 'package:flutter/material.dart';
import 'package:smartcart/theme/app_theme.dart';

/// App-wide color aliases mapped to [AppTheme] brand tokens.
class AppColors {
  static const Color primary = AppTheme.primary;
  static const Color primaryDark = Color(0xFF059669);
  static const Color primaryLight = Color(0xFFD1FAE5);
  static const Color secondary = AppTheme.secondary;
  static const Color categoryTint = Color(0xFFECFDF5);
  static const Color background = AppTheme.bgLight;
  static const Color surface = Colors.white;
  static const Color cardBorder = AppTheme.borderLight;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color navInactive = Color(0xFF64748B);
  static const Color navActive = AppTheme.primary;
  static const Color accent = AppTheme.accent;
  static const Color danger = AppTheme.danger;
  static const Color success = AppTheme.success;
}
