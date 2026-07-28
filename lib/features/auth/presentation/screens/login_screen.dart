import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';
import '../widgets/social_auth_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitPhone() async {
    if (!_formKey.currentState!.validate()) return;
    final phone = _phoneController.text.trim();
    await ref.read(authProvider.notifier).sendOtp(phone);
    if (!mounted) return;
    final error = ref.read(authProvider).error;
    if (error == null) {
      context.push('/otp', extra: phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Icon(Icons.live_tv_rounded, size: 72, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'AyatShah Live',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Go live. Connect. Earn.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: const InputDecoration(
                            hintText: '+92 3XX XXXXXXX',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          validator: Validators.phone,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: authState.isLoading ? null : _submitPhone,
                          child: authState.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Send OTP'),
                        ),
                        if (authState.error != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            authState.error!,
                            style: const TextStyle(color: AppColors.error, fontSize: 12),
                          ),
                        ],
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('or continue with',
                                  style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SocialAuthButton(
                          label: 'Continue with Google',
                          icon: Icons.g_mobiledata,
                          onPressed: () => ref.read(authProvider.notifier).loginWithGoogle(),
                        ),
                        const SizedBox(height: 12),
                        SocialAuthButton(
                          label: 'Continue with Apple',
                          icon: Icons.apple,
                          onPressed: () => ref.read(authProvider.notifier).loginWithApple(),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => ref.read(authProvider.notifier).loginAsGuest(),
                          child: const Text('Continue as Guest'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
