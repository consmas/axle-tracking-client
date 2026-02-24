import 'package:axle_tracking_cms/core/config/app_router.dart';
import 'package:axle_tracking_cms/core/config/env.dart';
import 'package:axle_tracking_cms/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.load();
  if (kDebugMode) {
    debugPrint('[ENV] API_BASE_URL=${EnvConfig.baseUrl}');
  }
  runApp(const ProviderScope(child: AxleTrackingCmsApp()));
}

class AxleTrackingCmsApp extends ConsumerWidget {
  const AxleTrackingCmsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Axle Tracking',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
