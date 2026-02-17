import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Colors ──
  static const Color primaryBlue = Color(0xFF1A3FCC);
  static const Color deepBlue = Color(0xFF0A2494);
  static const Color accentBlue = Color(0xFF3B5FE8);
  static const Color lightBlue = Color(0xFF93C5FD);
  static const Color bgColor = Color(0xFFF5F7FF);
  static const Color safeGreen = Color(0xFF10B981);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color dangerRed = Color(0xFFEF4444);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textGrey = Color(0xFF64748B);
  static const Color cardWhite = Color(0xFFFFFFFF);

  // ── Typography helpers ──
  static TextStyle syneHeading(double size, Color color) =>
      GoogleFonts.syne(fontSize: size, fontWeight: FontWeight.w700, color: color);

  static TextStyle dmBody(double size, Color color) =>
      GoogleFonts.dmSans(fontSize: size, color: color);

  // ── Decoration helpers ──
  static BoxDecoration blueGradientBox({double radius = 0}) => BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [deepBlue, accentBlue],
        ),
        borderRadius: BorderRadius.circular(radius),
      );

  static BoxDecoration cardDecoration({double radius = 20}) => BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3FCC).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      );
}
