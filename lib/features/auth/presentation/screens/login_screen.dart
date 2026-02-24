import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/auth/presentation/controllers/auth_controller.dart';
import 'package:axle_tracking_cms/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController =
      TextEditingController(text: 'admin@axle.com');
  final _passwordController = TextEditingController(text: 'password');
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authControllerProvider, (_, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline_rounded,
                      color: AxleColors.critical, size: 16),
                  const SizedBox(width: 8),
                  Text(next.errorMessage!),
                ],
              ),
            ),
          );
      }
    });

    return Scaffold(
      body: AxleBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;

            if (isWide) {
              return Row(
                children: [
                  // ── Left panel: branding ─────────────────────────────
                  Expanded(
                    flex: 5,
                    child: _BrandPanel(),
                  ),

                  // ── Right panel: form ────────────────────────────────
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AxleColors.bgSidebar,
                        border: const Border(
                          left: BorderSide(color: AxleColors.border),
                        ),
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(AxleSpacing.xxxl),
                          child: ConstrainedBox(
                            constraints:
                                const BoxConstraints(maxWidth: 380),
                            child: _LoginForm(
                              emailController: _emailController,
                              passwordController: _passwordController,
                              formKey: _formKey,
                              isLoading: isLoading,
                              obscurePassword: _obscurePassword,
                              onToggleObscure: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                              onSubmit: () => _submit(),
                              onRegister: () => context.push('/register'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            // Mobile: centered card
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AxleSpacing.xl),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    children: [
                      // Compact brand mark
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: AxleColors.accentGradient,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AxleColors.accent
                                      .withValues(alpha: 0.3),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.navigation_rounded,
                                color: AxleColors.bg, size: 22),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'AXLETRACK',
                            style: TextStyle(
                              color: AxleColors.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      AxleGlassCard(
                        padding: const EdgeInsets.all(AxleSpacing.xxl),
                        child: _LoginForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: _formKey,
                          isLoading: isLoading,
                          obscurePassword: _obscurePassword,
                          onToggleObscure: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                          onSubmit: () => _submit(),
                          onRegister: () => context.push('/register'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authControllerProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }
}

// ── Brand Panel (left side) ───────────────────────────────────────────────────

class _BrandPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AxleSpacing.xxxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo mark
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: AxleColors.accentGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AxleColors.accent.withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.navigation_rounded,
                color: AxleColors.bg, size: 26),
          ),
          const SizedBox(height: 24),

          const Text(
            'AXLETRACK',
            style: TextStyle(
              color: AxleColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 28,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Fleet Intelligence Platform',
            style: TextStyle(
              color: AxleColors.accent,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Enterprise-grade fleet management\nfor modern logistics operations.',
            style: TextStyle(
              color: AxleColors.textSecondary,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 40),

          // Feature list
          const _Feature(
            icon: Icons.map_rounded,
            title: 'Live Tracking',
            subtitle: 'Real-time GPS positions on interactive maps',
          ),
          const SizedBox(height: 16),
          const _Feature(
            icon: Icons.play_circle_rounded,
            title: 'Route Playback',
            subtitle: 'Historical route visualization with timeline',
          ),
          const SizedBox(height: 16),
          const _Feature(
            icon: Icons.notifications_active_rounded,
            title: 'Smart Alarms',
            subtitle: 'Instant alerts with severity classification',
          ),
          const SizedBox(height: 16),
          const _Feature(
            icon: Icons.videocam_rounded,
            title: 'Live Video',
            subtitle: 'Multi-channel MDVR camera feeds',
          ),
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AxleColors.accentDim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 17, color: AxleColors.accent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AxleColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AxleColors.textMuted,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Login Form ────────────────────────────────────────────────────────────────

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.obscurePassword,
    required this.onToggleObscure,
    required this.onSubmit,
    required this.onRegister,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final bool obscurePassword;
  final VoidCallback onToggleObscure;
  final VoidCallback onSubmit;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sign In',
            style: TextStyle(
              color: AxleColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Enter your credentials to continue',
            style: TextStyle(
              color: AxleColors.textMuted,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 28),

          // Email field
          _FieldLabel('EMAIL ADDRESS'),
          const SizedBox(height: 6),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: AxleColors.textPrimary,
              fontSize: 13,
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                size: 16,
                color: AxleColors.textMuted,
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email is required';
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password field
          _FieldLabel('PASSWORD'),
          const SizedBox(height: 6),
          TextFormField(
            controller: passwordController,
            obscureText: obscurePassword,
            style: const TextStyle(
              color: AxleColors.textPrimary,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                size: 16,
                color: AxleColors.textMuted,
              ),
              suffixIcon: IconButton(
                onPressed: onToggleObscure,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 16,
                  color: AxleColors.textMuted,
                ),
              ),
            ),
            validator: (v) {
              if (v == null || v.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 26),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: isLoading ? null : AxleColors.accentGradient,
                color: isLoading
                    ? AxleColors.accent.withValues(alpha: 0.3)
                    : null,
                borderRadius: BorderRadius.circular(AxleRadius.lg),
                boxShadow: isLoading
                    ? null
                    : [
                        BoxShadow(
                          color: AxleColors.accent.withValues(alpha: 0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: ElevatedButton(
                onPressed: isLoading ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AxleRadius.lg),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation(AxleColors.bg),
                        ),
                      )
                    : const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AxleColors.bg,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Register link
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: AxleColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: onRegister,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(
                      color: AxleColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        letterSpacing: 1.0,
        color: AxleColors.textSecondary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
