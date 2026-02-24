import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:flutter/material.dart';

// ── Background ───────────────────────────────────────────────────────────────

class AxleBackground extends StatelessWidget {
  const AxleBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AxleColors.bgGradient),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.18,
                child: CustomPaint(painter: _GridPatternPainter()),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

// ── Glass Card ───────────────────────────────────────────────────────────────

class AxleGlassCard extends StatelessWidget {
  const AxleGlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.radius = AxleRadius.xl,
    this.borderColor,
    this.glow = false,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color? borderColor;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration:
          axleGlassCard(radius: radius, borderColor: borderColor, glow: glow),
      child: child,
    );
  }
}

// ── Status Pill ──────────────────────────────────────────────────────────────

class StatusPill extends StatelessWidget {
  const StatusPill({required this.online, super.key});

  final bool online;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: online
            ? AxleColors.accentDim
            : AxleColors.textMuted.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AxleRadius.pill),
        border: Border.all(
          color: online
              ? AxleColors.accent.withValues(alpha: 0.25)
              : AxleColors.textMuted.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: online ? AxleColors.accent : AxleColors.textMuted,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            online ? 'ONLINE' : 'OFFLINE',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: online ? AxleColors.accent : AxleColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Severity Pill ────────────────────────────────────────────────────────────

class SeverityPill extends StatelessWidget {
  const SeverityPill({required this.value, super.key});

  final String value;

  static Color colorFor(String v) {
    if (v.contains('crit')) return AxleColors.critical;
    if (v.contains('warn')) return AxleColors.warning;
    return AxleColors.info;
  }

  @override
  Widget build(BuildContext context) {
    final v = value.toLowerCase();
    final color = colorFor(v);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AxleRadius.sm),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        value.toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: color,
        ),
      ),
    );
  }
}

// ── Metric Card ──────────────────────────────────────────────────────────────

class AxleMetricCard extends StatelessWidget {
  const AxleMetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.accentColor,
    this.subtitle,
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accentColor;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AxleRadius.xl),
      child: Container(
        decoration: BoxDecoration(
          gradient: AxleColors.cardGradient,
          borderRadius: BorderRadius.circular(AxleRadius.xl),
          border: Border.all(color: AxleColors.borderCard),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AxleRadius.xl),
                    topRight: Radius.circular(AxleRadius.xl),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AxleSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icon, color: accentColor, size: 18),
                      ),
                      const Spacer(),
                      if (onTap != null)
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 11,
                          color: AxleColors.textMuted,
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    value,
                    style: const TextStyle(
                      color: AxleColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 34,
                      height: 1,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    label.toUpperCase(),
                    style: const TextStyle(
                      color: AxleColors.textSecondary,
                      fontSize: 10,
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AxleColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quick Action Card ─────────────────────────────────────────────────────────

class AxleQuickAction extends StatelessWidget {
  const AxleQuickAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AxleColors.accent;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AxleRadius.xl),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(AxleRadius.xl),
          border: Border.all(color: c.withValues(alpha: 0.18)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: c.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: c, size: 20),
            ),
            const SizedBox(height: 9),
            Text(
              label,
              style: const TextStyle(
                color: AxleColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Loading Skeleton ─────────────────────────────────────────────────────────

class AxleSkeleton extends StatefulWidget {
  const AxleSkeleton({
    required this.width,
    required this.height,
    this.radius = AxleRadius.md,
    super.key,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<AxleSkeleton> createState() => _AxleSkeletonState();
}

class _AxleSkeletonState extends State<AxleSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.25, end: 0.65).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AxleColors.bgElevated,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

class AxleSectionHeader extends StatelessWidget {
  const AxleSectionHeader({
    required this.title,
    this.trailing,
    super.key,
  });

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: AxleColors.textMuted,
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 1, color: AxleColors.border)),
        if (trailing != null) ...[
          const SizedBox(width: 10),
          trailing!,
        ],
      ],
    );
  }
}

// ── Grid Pattern Painter ──────────────────────────────────────────────────────

class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AxleColors.accent.withValues(alpha: 0.07)
      ..strokeWidth = 0.5;

    const step = 56.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final dotPaint = Paint()
      ..color = AxleColors.accent.withValues(alpha: 0.14)
      ..style = PaintingStyle.fill;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.5, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
