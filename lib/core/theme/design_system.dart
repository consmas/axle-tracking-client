import 'package:flutter/material.dart';

class AxleColors {
  AxleColors._();

  // ── Background stack (deep navy) ──────────────────────────────────────────
  static const Color bg = Color(0xFF080D18);
  static const Color bgSidebar = Color(0xFF060C18);
  static const Color bgCard = Color(0xFF0C1525);
  static const Color bgElevated = Color(0xFF101C30);
  static const Color bgHover = Color(0xFF14223A);

  // ── Accent — Neon Green ────────────────────────────────────────────────────
  static const Color accent = Color(0xFF00E676);
  static const Color accentDark = Color(0xFF00C853);
  static const Color accentDim = Color(0x1800E676);
  static const Color accentGlow = Color(0x3000E676);

  // ── Status ─────────────────────────────────────────────────────────────────
  static const Color warning = Color(0xFFFFB300);
  static const Color warningDim = Color(0x18FFB300);
  static const Color critical = Color(0xFFFF4444);
  static const Color criticalDim = Color(0x18FF4444);
  static const Color info = Color(0xFF4D8EFF);
  static const Color infoDim = Color(0x184D8EFF);

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF7B8CA8);
  static const Color textMuted = Color(0xFF3D5070);

  // ── Borders ────────────────────────────────────────────────────────────────
  static const Color border = Color(0x0DFFFFFF);
  static const Color borderLight = Color(0x18FFFFFF);
  static const Color borderCard = Color(0x12FFFFFF);
  static const Color borderAccent = Color(0x2900E676);

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [bgCard, bgElevated],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sidebarGradient = LinearGradient(
    colors: [bgSidebar, Color(0xFF07101E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [bg, Color(0xFF060B15)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AxleSpacing {
  AxleSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

class AxleRadius {
  AxleRadius._();

  static const double sm = 6;
  static const double md = 10;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 20;
  static const double pill = 100;
}

BoxDecoration axleGlassCard({
  double radius = AxleRadius.xl,
  Color? borderColor,
  bool glow = false,
}) {
  return BoxDecoration(
    gradient: AxleColors.cardGradient,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color: borderColor ?? AxleColors.borderCard,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.35),
        blurRadius: 20,
        offset: const Offset(0, 6),
      ),
      if (glow)
        BoxShadow(
          color: AxleColors.accent.withValues(alpha: 0.08),
          blurRadius: 32,
          spreadRadius: 0,
        ),
    ],
  );
}
