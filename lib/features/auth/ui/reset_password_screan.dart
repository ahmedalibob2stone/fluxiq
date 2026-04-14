
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_route_names.dart.dart';
import '../../../core/widgets/fluxiq_snackbar.dart';
import '../core/validators/auth_validators.dart';
import '../core/widgets/auth_text_field.dart';
import '../core/widgets/fluxiq_title.dart';
import '../core/widgets/gradient_text_button.dart';
import '../core/widgets/send_reset_link_button.dar.dart';
import '../provider/password_reset_viewmodel_provider.dart';
import '../state/password_reset_state.dart';


class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(
      passwordResetViewModelProvider.select((s) => s.loading),
    );

    ref.listen<PasswordResetState>(
      passwordResetViewModelProvider,
          (prev, next) {
        if (next.error != null && next.error != prev?.error) {
          FluxIQSnackBar.showError(context, next.error!);
        }

        if (next.step == PasswordResetStep.emailSent &&
            prev?.step == PasswordResetStep.enterEmail) {
          FluxIQSnackBar.showSuccess(context, next.success ?? '');
          context.pushNamed(
            AppRouteNames.newPassword,
            queryParameters: {'email': next.email},
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FluxIQTitle(fontSize: 36),
                    const SizedBox(height: 16),
                    Text(
                      'Enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AuthTextField(
                      hint: 'Email',
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      validator: AuthValidators.validateEmail,
                    ),
                    const SizedBox(height: 24),

                    SendResetLinkButton(
                      isLoading: loading,
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        if (_formKey.currentState?.validate() ?? false) {
                          final email = _emailCtrl.text.trim();

                          ref
                              .read(passwordResetViewModelProvider.notifier)
                              .sendResetLink(email);
                        }
                      },
                    ),

                    const SizedBox(height: 16),
                    GradientTextButton(
                      text: 'Back to Login',
                        onPressed: () => context.goNamed(AppRouteNames.login)                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}