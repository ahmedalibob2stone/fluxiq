import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxiq/features/auth/core/widgets/login_button.dart';
import 'package:fluxiq/features/auth/ui/widgets/new%20password/resend_link_button.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_route_names.dart.dart';
import '../../../core/widgets/fluxiq_snackbar.dart';
import '../core/validators/auth_validators.dart';
import '../core/widgets/auth_text_field.dart';
import '../core/widgets/email_sent_badge.dart';
import '../core/widgets/fluxiq_title.dart';
import '../core/widgets/gradient_text_button.dart';
import '../provider/auth_viewmodel_provider.dart';
import '../provider/password_reset_viewmodel_provider.dart';
import '../state/auth_state.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  final String email;

  const NewPasswordScreen({super.key, required this.email});

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordCtrl;
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _passwordCtrl = TextEditingController();

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final loginLoading = ref.watch(
      authViewModelProvider.select((s) => s.loading),
    );

    ref.listen<AuthState>(
      authViewModelProvider,
          (prev, next) {
        if (next.error != null && next.error != prev?.error) {
          FluxIQSnackBar.showError(context, next.error!);
        }

        if (next.status == AuthStatus.authenticated &&
            prev?.status != AuthStatus.authenticated) {
          context.goNamed(AppRouteNames.home);
        }
      },
    );

    ref.listen(
      passwordResetViewModelProvider.select((s) => s.success),
          (prev, next) {
        if (next != null && next != prev) {
          FluxIQSnackBar.showSuccess(context, next);
        }
      },
    );

    ref.listen(
      passwordResetViewModelProvider.select((s) => s.error),
          (prev, next) {
        if (next != null && next != prev) {
          FluxIQSnackBar.showError(context, next);
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.064,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: size.height * 0.03),

                        FluxIQTitle(
                          fontSize: size.width * 0.096,
                        ),
                        SizedBox(height: size.height * 0.045),

                        EmailSentBadge(email: widget.email),
                        SizedBox(height: size.height * 0.04),

                        Text(
                          'Enter New Password',
                          style: TextStyle(
                            fontSize: size.width * 0.058,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueGrey.shade800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                          ),
                          child: Text(
                            'We sent a reset link to your email.\n'
                                'Reset your password, then log in below.',
                            style: TextStyle(
                              fontSize: size.width * 0.037,
                              color: Colors.blueGrey.shade400,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: size.height * 0.045),

                        AuthTextField(
                          hint: 'New Password',
                          controller: _passwordCtrl,
                          obscure: true,
                          validator: AuthValidators.validatePassword,
                        ),
                        SizedBox(height: size.height * 0.03),

                        LogInButton(
                          isLoading: loginLoading,
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (_formKey.currentState?.validate() ?? false) {
                              ref.read(authViewModelProvider.notifier).login(
                                widget.email,
                                _passwordCtrl.text.trim(),
                              );
                            }
                          },
                        ),

                        SizedBox(height: size.height * 0.015),


                        const ResendLinkButton(),

                        SizedBox(height: size.height * 0.015),

                        GradientTextButton(
                          text: 'Back to Login',
                          onPressed: () => context.goNamed(AppRouteNames.login),
                        ),
                        SizedBox(height: size.height * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}