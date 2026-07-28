import 'package:flutter/material.dart';

/// AyatShah Live — Dark Purple Palette
class AppColors {
  AppColors._();

  // Core brand purples
  static const Color primary = Color(0xFF7B2FF7);
  static const Color primaryDark = Color(0xFF4A148C);
  static const Color primaryLight = Color(0xFFB388FF);

  // Secondary / accent (used for gifts, PK, live badges)
  static const Color accentPink = Color(0xFFE040FB);
  static const Color accentGold = Color(0xFFFFC107);
  static const Color accentRed = Color(0xFFFF3D57); // PK team A
  static const Color accentBlue = Color(0xFF2979FF); // PK team B

  // Backgrounds
  static const Color backgroundDark = Color(0xFF120318);
  static const Color surfaceDark = Color(0xFF1E0B2E);
  static const Color surfaceElevated = Color(0xFF2A1140);
  static const Color cardDark = Color(0xFF261238);

  // Text
  static const Color textPrimary = Color(0xFFF5EFFF);
  static const Color textSecondary = Color(0xFFC9B8DE);
  static const Color textMuted = Color(0xFF8B7A9E);

  // Status
  static const Color success = Color(0xFF00E676);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFB300);
  static const Color online = Color(0xFF00E676);
  static const Color live = Color(0xFFFF3D57);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7B2FF7), Color(0xFF4A148C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient liveGradient = LinearGradient(
    colors: [Color(0xFFFF3D57), Color(0xFFB0003A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFD54F), Color(0xFFFF8F00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pkTeamAGradient = LinearGradient(
    colors: [Color(0xFFFF3D57), Color(0xFFFF7A8A)],
  );

  static const LinearGradient pkTeamBGradient = LinearGradient(
    colors: [Color(0xFF2979FF), Color(0xFF75A7FF)],
  );
}
