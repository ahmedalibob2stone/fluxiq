import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_route_names.dart.dart';

import '../../../core/widgets/fluxiq_snackbar.dart';
import '../../../core/widgets/fluxiq_button_widget.dart';


import '../core/validators/auth_validators.dart';
import '../core/widgets/auth_text_field.dart';
import '../core/widgets/fluxiq_title.dart';
import '../core/widgets/gradient_text_button.dart';
import '../provider/auth_viewmodel_provider.dart';
import '../state/auth_state.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        FluxIQSnackBar.showError(context, next.error!);
      }

      if (next.status == AuthStatus.authenticated &&
          previous?.status != AuthStatus.authenticated) {
        context.goNamed(AppRouteNames.home);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth < 500
                        ? constraints.maxWidth
                        : 450,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FluxIQTitle(
                          fontSize: 36,
                        )

                        , SizedBox(height: 16),

                        Text(
                          'Login to your account to stay updated',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey.shade400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        AuthTextField(
                          hint: 'Email',
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: AuthValidators.validateEmail,
                        ),
                        const SizedBox(height: 16),

                        // Password
                        AuthTextField(
                          hint: 'Password',
                          controller: passCtrl,
                          obscure: true,
                         validator: AuthValidators.validatePassword,

                        ),
                        const SizedBox(height: 24),




                        const SizedBox(height: 16),
                        FluxIQButton(
                          label: 'Login',
                          isLoading: state.loading,
                          onPressed: () {
                            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              ref.read(authViewModelProvider.notifier).login(
                                emailCtrl.text.trim(),
                                passCtrl.text.trim(),
                              );
                            }
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.pushNamed(AppRouteNames.resetPassword),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.black54),
                            ),
                            GradientTextButton(
                              text: 'Register',
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              onPressed: () => context.goNamed(AppRouteNames.register),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

