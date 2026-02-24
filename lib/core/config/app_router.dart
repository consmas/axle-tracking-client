import 'package:axle_tracking_cms/core/widgets/app_shell.dart';
import 'package:axle_tracking_cms/features/alarms/presentation/screens/alarms_screen.dart';
import 'package:axle_tracking_cms/features/auth/presentation/controllers/auth_controller.dart';
import 'package:axle_tracking_cms/features/auth/presentation/providers/auth_providers.dart';
import 'package:axle_tracking_cms/features/auth/presentation/screens/login_screen.dart';
import 'package:axle_tracking_cms/features/auth/presentation/screens/register_screen.dart';
import 'package:axle_tracking_cms/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:axle_tracking_cms/features/settings/presentation/screens/settings_screen.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/screens/live_tracking_screen.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/screens/live_video_screen.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/screens/track_history_screen.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/screens/vehicle_status_detail_screen.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/screens/vehicles_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(location: state.matchedLocation, child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
              path: '/vehicles', builder: (_, __) => const VehiclesScreen()),
          GoRoute(
            path: '/vehicles/:id',
            builder: (context, state) => VehicleStatusDetailScreen(
                vehicleId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/tracking',
            builder: (_, __) => const LiveTrackingScreen(),
          ),
          GoRoute(
            path: '/playback',
            builder: (_, __) => const TrackHistoryScreen(),
          ),
          GoRoute(
            path: '/video',
            builder: (_, __) => const LiveVideoScreen(),
          ),
          GoRoute(path: '/alarms', builder: (_, __) => const AlarmsScreen()),
          GoRoute(
            path: '/settings',
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isAuth = authState.status == AuthStatus.authenticated;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isAuth && !isAuthRoute) {
        return '/login';
      }

      if (isAuth && isAuthRoute) {
        return '/dashboard';
      }

      return null;
    },
  );
});
