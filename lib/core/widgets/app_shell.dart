import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// ── breakpoint ────────────────────────────────────────────────────────────────
const double _kMobileBreakpoint = 720;

class AppShell extends ConsumerWidget {
  const AppShell({required this.child, required this.location, super.key});

  final Widget child;
  final String location;

  // ── Desktop nav items (6) ─────────────────────────────────────────────────
  static const _desktopItems = <_NavItem>[
    _NavItem(
      route: '/dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
      label: 'Dashboard',
    ),
    _NavItem(
      route: '/vehicles',
      icon: Icons.local_shipping_outlined,
      selectedIcon: Icons.local_shipping_rounded,
      label: 'Fleet',
    ),
    _NavItem(
      route: '/tracking',
      icon: Icons.map_outlined,
      selectedIcon: Icons.map_rounded,
      label: 'Live Map',
    ),
    _NavItem(
      route: '/playback',
      icon: Icons.play_circle_outline_rounded,
      selectedIcon: Icons.play_circle_rounded,
      label: 'Playback',
    ),
    _NavItem(
      route: '/alarms',
      icon: Icons.notifications_active_outlined,
      selectedIcon: Icons.notifications_active_rounded,
      label: 'Alarms',
    ),
    _NavItem(
      route: '/video',
      icon: Icons.videocam_outlined,
      selectedIcon: Icons.videocam_rounded,
      label: 'Live Video',
    ),
  ];

  // ── Mobile nav items (5) ──────────────────────────────────────────────────
  static const _mobileItems = <_NavItem>[
    _NavItem(
      route: '/dashboard',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavItem(
      route: '/vehicles',
      icon: Icons.local_shipping_outlined,
      selectedIcon: Icons.local_shipping_rounded,
      label: 'Fleet',
    ),
    _NavItem(
      route: '/tracking',
      icon: Icons.map_outlined,
      selectedIcon: Icons.map_rounded,
      label: 'Map',
    ),
    _NavItem(
      route: '/alarms',
      icon: Icons.notifications_active_outlined,
      selectedIcon: Icons.notifications_active_rounded,
      label: 'Alarms',
    ),
    _NavItem(
      route: '/settings',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.sizeOf(context).width < _kMobileBreakpoint;
    final authState = ref.watch(authControllerProvider);
    final userEmail = authState.user?.email ?? '';
    final userInitial = userEmail.isNotEmpty ? userEmail[0].toUpperCase() : 'A';
    final userName = userEmail.contains('@')
        ? userEmail.split('@').first
        : userEmail.isNotEmpty
            ? userEmail
            : 'Admin';

    if (isMobile) {
      return _MobileShell(
        location: location,
        userName: userName,
        userInitial: userInitial,
        child: child,
      );
    }

    return _DesktopShell(
      location: location,
      userName: userName,
      userInitial: userInitial,
      onLogout: () => ref.read(authControllerProvider.notifier).logout(),
      child: child,
    );
  }

  // ── Shared helpers ────────────────────────────────────────────────────────

  static int _desktopIndex(String path) {
    if (path.startsWith('/vehicles')) return 1;
    if (path.startsWith('/tracking')) return 2;
    if (path.startsWith('/playback')) return 3;
    if (path.startsWith('/alarms')) return 4;
    if (path.startsWith('/video')) return 5;
    return 0;
  }

  static int _mobileIndex(String path) {
    if (path.startsWith('/vehicles')) return 1;
    if (path.startsWith('/tracking')) return 2;
    if (path.startsWith('/alarms')) return 3;
    if (path.startsWith('/settings')) return 4;
    return 0;
  }

  static String _titleFor(String path) {
    if (path.startsWith('/vehicles/')) return 'Vehicle Detail';
    if (path.startsWith('/vehicles')) return 'Fleet';
    if (path.startsWith('/tracking')) return 'Live Map';
    if (path.startsWith('/playback')) return 'Playback';
    if (path.startsWith('/alarms')) return 'Alarms';
    if (path.startsWith('/video')) return 'Live Video';
    if (path.startsWith('/settings')) return 'Profile';
    return 'Dashboard';
  }

  static String _subtitleFor(String path) {
    if (path.startsWith('/vehicles/')) return 'Status and diagnostics';
    if (path.startsWith('/vehicles')) return 'Monitor and manage your fleet';
    if (path.startsWith('/tracking')) return 'Real-time vehicle positions';
    if (path.startsWith('/playback')) return 'Historical route visualization';
    if (path.startsWith('/alarms')) return 'Events and alert management';
    if (path.startsWith('/video')) return 'Live camera feeds';
    if (path.startsWith('/settings')) return 'Account & preferences';
    return 'Fleet operations overview';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MOBILE SHELL
// ═══════════════════════════════════════════════════════════════════════════════

class _MobileShell extends StatelessWidget {
  const _MobileShell({
    required this.location,
    required this.child,
    required this.userName,
    required this.userInitial,
  });

  final String location;
  final Widget child;
  final String userName;
  final String userInitial;

  @override
  Widget build(BuildContext context) {
    final selectedIdx = AppShell._mobileIndex(location);
    final title = AppShell._titleFor(location);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AxleColors.bgSidebar,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AxleColors.bg,
        appBar: _MobileAppBar(title: title, location: location),
        body: child,
        bottomNavigationBar: _MobileNavBar(
          selectedIndex: selectedIdx,
          location: location,
        ),
      ),
    );
  }
}

// ── Mobile App Bar ────────────────────────────────────────────────────────────

class _MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MobileAppBar({required this.title, required this.location});

  final String title;
  final String location;

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height + MediaQuery.paddingOf(context).top,
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      decoration: const BoxDecoration(
        color: AxleColors.bgSidebar,
        border: Border(bottom: BorderSide(color: AxleColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Brand mark
            SvgPicture.asset(
              'assets/images/logo_mark.svg',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),

            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AxleColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: -0.3,
                ),
              ),
            ),

            // Connection status pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AxleColors.accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AxleColors.accent.withValues(alpha: 0.20),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PulseDot(),
                  SizedBox(width: 5),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      color: AxleColors.accent,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Notification bell
            GestureDetector(
              onTap: () => context.go('/alarms'),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AxleColors.bgCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AxleColors.border),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      size: 18,
                      color: AxleColors.textSecondary,
                    ),
                    Positioned(
                      right: 7,
                      top: 7,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: AxleColors.critical,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AxleColors.bgSidebar,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Mobile Bottom Navigation Bar ──────────────────────────────────────────────

class _MobileNavBar extends StatelessWidget {
  const _MobileNavBar({
    required this.selectedIndex,
    required this.location,
  });

  final int selectedIndex;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AxleColors.bgSidebar,
        border: Border(top: BorderSide(color: AxleColors.border)),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.transparent,
          indicatorColor: AxleColors.accentDim,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          height: 64,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AxleColors.accent, size: 22);
            }
            return const IconThemeData(color: AxleColors.textMuted, size: 22);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: AxleColors.accent,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              );
            }
            return const TextStyle(
              color: AxleColors.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          animationDuration: const Duration(milliseconds: 250),
          onDestinationSelected: (i) {
            final route = AppShell._mobileItems[i].route;
            if (location != route) context.go(route);
          },
          destinations: AppShell._mobileItems
              .map(
                (item) => NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon),
                  label: item.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// DESKTOP SHELL
// ═══════════════════════════════════════════════════════════════════════════════

class _DesktopShell extends StatelessWidget {
  const _DesktopShell({
    required this.location,
    required this.child,
    required this.userName,
    required this.userInitial,
    required this.onLogout,
  });

  final String location;
  final Widget child;
  final String userName;
  final String userInitial;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final idx = AppShell._desktopIndex(location);

    return Scaffold(
      body: Row(
        children: [
          // ── Sidebar ───────────────────────────────────────────────────────
          Container(
            width: 240,
            decoration: const BoxDecoration(
              gradient: AxleColors.sidebarGradient,
              border: Border(right: BorderSide(color: AxleColors.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/lockup_horizontal.svg',
                        width: 165,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AxleColors.border),
                const SizedBox(height: 14),

                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, 8),
                  child: Text(
                    'NAVIGATION',
                    style: TextStyle(
                      color: AxleColors.textMuted,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),

                for (var i = 0; i < AppShell._desktopItems.length; i++)
                  _SidebarTile(
                    item: AppShell._desktopItems[i],
                    selected: i == idx,
                    onTap: () {
                      if (location != AppShell._desktopItems[i].route) {
                        context.go(AppShell._desktopItems[i].route);
                      }
                    },
                  ),

                const Spacer(),
                const Divider(height: 1, color: AxleColors.border),

                // User / sign-out
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4D8EFF), Color(0xFF2A5FCC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            userInitial,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                color: AxleColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Text(
                              'Administrator',
                              style: TextStyle(
                                color: AxleColors.textMuted,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: onLogout,
                        icon: const Icon(
                          Icons.logout_rounded,
                          size: 16,
                          color: AxleColors.textMuted,
                        ),
                        tooltip: 'Sign Out',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 28,
                          minHeight: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Main area ─────────────────────────────────────────────────────
          Expanded(
            child: Column(
              children: [
                // Header bar
                Container(
                  height: 62,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: const BoxDecoration(
                    color: AxleColors.bg,
                    border: Border(
                      bottom: BorderSide(color: AxleColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppShell._titleFor(location),
                            style: const TextStyle(
                              color: AxleColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            AppShell._subtitleFor(location),
                            style: const TextStyle(
                              color: AxleColors.textMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Status pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AxleColors.accent.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AxleColors.accent.withValues(alpha: 0.2),
                          ),
                        ),
                        child: const Row(
                          children: [
                            _PulseDot(),
                            SizedBox(width: 6),
                            Text(
                              'CONNECTED',
                              style: TextStyle(
                                color: AxleColors.accent,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Notifications
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AxleColors.bgCard,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AxleColors.border),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.notifications_outlined,
                              size: 17,
                              color: AxleColors.textSecondary,
                            ),
                            Positioned(
                              right: 7,
                              top: 7,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: AxleColors.critical,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AxleColors.bg,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // User avatar
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4D8EFF), Color(0xFF2A5FCC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            userInitial,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SHARED COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

// ── Sidebar Tile (desktop only) ───────────────────────────────────────────────

class _SidebarTile extends StatefulWidget {
  const _SidebarTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<_SidebarTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Stack(
          children: [
            if (selected)
              Positioned(
                left: 0,
                top: 4,
                bottom: 4,
                child: Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: AxleColors.accent,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(3),
                      bottomRight: Radius.circular(3),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: widget.onTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AxleColors.accentDim
                        : _hovered
                            ? AxleColors.bgHover.withValues(alpha: 0.5)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: selected
                              ? AxleColors.accentGlow
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          selected
                              ? widget.item.selectedIcon
                              : widget.item.icon,
                          size: 17,
                          color: selected
                              ? AxleColors.accent
                              : _hovered
                                  ? AxleColors.textSecondary
                                  : AxleColors.textMuted,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.item.label,
                        style: TextStyle(
                          color: selected
                              ? AxleColors.textPrimary
                              : _hovered
                                  ? AxleColors.textSecondary
                                  : AxleColors.textMuted,
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 13,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Pulsing dot ───────────────────────────────────────────────────────────────

class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
      lowerBound: 0.35,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          color: AxleColors.accent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ── Nav item model ────────────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({
    required this.route,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final String route;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
