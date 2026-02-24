import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final userEmail = authState.user?.email ?? '';
    final userInitial =
        userEmail.isNotEmpty ? userEmail[0].toUpperCase() : 'A';
    final userName = userEmail.contains('@')
        ? userEmail.split('@').first
        : userEmail.isNotEmpty
            ? userEmail
            : 'Admin';

    return AxleBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AxleSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Profile header ────────────────────────────────────────────
            AxleGlassCard(
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4D8EFF), Color(0xFF2A5FCC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4D8EFF)
                              .withValues(alpha: 0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        userInitial,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: AxleColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      color: AxleColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AxleColors.accentDim,
                      borderRadius:
                          BorderRadius.circular(AxleRadius.pill),
                      border: Border.all(
                        color: AxleColors.accent.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Text(
                      'Administrator',
                      style: TextStyle(
                        color: AxleColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Navigate section (mobile shortcuts) ───────────────────────
            _SectionLabel('Navigate'),
            _SettingsGroup(
              children: [
                _SettingsRow(
                  icon: Icons.videocam_rounded,
                  iconColor: AxleColors.info,
                  label: 'Live Video',
                  subtitle: 'All channel camera feeds',
                  onTap: () => context.go('/video'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: AxleColors.textMuted,
                  ),
                ),
                _Divider(),
                _SettingsRow(
                  icon: Icons.play_circle_fill_rounded,
                  iconColor: AxleColors.warning,
                  label: 'Route Playback',
                  subtitle: 'Historical trip visualization',
                  onTap: () => context.go('/playback'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: AxleColors.textMuted,
                  ),
                ),
                _Divider(),
                _SettingsRow(
                  icon: Icons.map_rounded,
                  iconColor: AxleColors.accent,
                  label: 'Live Map',
                  subtitle: 'Real-time vehicle positions',
                  onTap: () => context.go('/tracking'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: AxleColors.textMuted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Preferences ───────────────────────────────────────────────
            _SectionLabel('Preferences'),
            _SettingsGroup(
              children: [
                _SettingsRow(
                  icon: Icons.notifications_active_rounded,
                  iconColor: AxleColors.warning,
                  label: 'Push Notifications',
                  subtitle: 'Alarms and system alerts',
                  trailing: Switch(
                    value: true,
                    onChanged: (_) {},
                    activeThumbColor: AxleColors.accent,
                    activeTrackColor: AxleColors.accentDim,
                    inactiveThumbColor: AxleColors.textMuted,
                    inactiveTrackColor:
                        AxleColors.textMuted.withValues(alpha: 0.12),
                  ),
                ),
                _Divider(),
                _SettingsRow(
                  icon: Icons.speed_rounded,
                  iconColor: AxleColors.info,
                  label: 'Speed Unit',
                  subtitle: 'Kilometres per hour',
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AxleColors.bgElevated,
                      borderRadius:
                          BorderRadius.circular(AxleRadius.sm),
                      border: Border.all(color: AxleColors.border),
                    ),
                    child: const Text(
                      'km/h',
                      style: TextStyle(
                        color: AxleColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                _Divider(),
                _SettingsRow(
                  icon: Icons.refresh_rounded,
                  iconColor: AxleColors.accent,
                  label: 'Map Refresh Rate',
                  subtitle: 'How often positions update',
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AxleColors.bgElevated,
                      borderRadius:
                          BorderRadius.circular(AxleRadius.sm),
                      border: Border.all(color: AxleColors.border),
                    ),
                    child: const Text(
                      '30s',
                      style: TextStyle(
                        color: AxleColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── About ─────────────────────────────────────────────────────
            _SectionLabel('About'),
            _SettingsGroup(
              children: [
                _SettingsRow(
                  icon: Icons.info_outline_rounded,
                  iconColor: AxleColors.textSecondary,
                  label: 'App Version',
                  subtitle: 'AxleTrack CMS',
                  trailing: const Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: AxleColors.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _Divider(),
                _SettingsRow(
                  icon: Icons.shield_outlined,
                  iconColor: AxleColors.accent,
                  label: 'Privacy Policy',
                  onTap: () {},
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: AxleColors.textMuted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Sign out ──────────────────────────────────────────────────
            OutlinedButton.icon(
              onPressed: () async {
                await ref
                    .read(authControllerProvider.notifier)
                    .logout();
              },
              icon: const Icon(Icons.logout_rounded, size: 17),
              label: const Text('Sign Out'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AxleColors.critical,
                side: BorderSide(
                  color: AxleColors.critical.withValues(alpha: 0.35),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AxleRadius.xl),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AxleColors.textMuted,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

// ── Settings group card ───────────────────────────────────────────────────────

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: axleGlassCard(radius: AxleRadius.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

// ── Divider ───────────────────────────────────────────────────────────────────

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 56,
      color: AxleColors.border,
    );
  }
}

// ── Row item ──────────────────────────────────────────────────────────────────

class _SettingsRow extends StatefulWidget {
  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  State<_SettingsRow> createState() => _SettingsRowState();
}

class _SettingsRowState extends State<_SettingsRow> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: widget.onTap != null
          ? (_) => setState(() => _pressed = true)
          : null,
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: _pressed
              ? AxleColors.bgHover.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AxleRadius.xl),
        ),
        child: Row(
          children: [
            // Icon badge
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.icon,
                size: 17,
                color: widget.iconColor,
              ),
            ),
            const SizedBox(width: 14),

            // Label + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(
                      color: AxleColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle!,
                      style: const TextStyle(
                        color: AxleColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (widget.trailing != null) ...[
              const SizedBox(width: 8),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
