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


class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameCtrl;
  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FluxIQTitle(fontSize: 36),
                  const SizedBox(height: 16),
                  Text(
                    'Create your account to stay updated',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey.shade400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          key: const Key('register_name_field'),
                          hint: 'Full Name',
                          controller: nameCtrl,
                          validator: (value) =>
                          value != null && value.isNotEmpty
                              ? null
                              : 'Please enter your name',
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(

                          key: const Key('register_email_field'),

                          hint: 'Email',
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: AuthValidators.validateEmail,

                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          key: const Key('register_password_field'),

                          hint: 'Password',
                          controller: passCtrl,
                          obscure: true,
                          validator: AuthValidators.validatePassword,

                        ),
                        const SizedBox(height: 24),

                        FluxIQButton(
                          label: 'Register',
                          isLoading: state.loading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(authViewModelProvider.notifier).register(
                                nameCtrl.text.trim(),
                                emailCtrl.text.trim(),
                                passCtrl.text.trim(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text("OR", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),

                  FluxIQButton(
                    label: 'Sign in with Google',
                    isLoading: state.isGoogleLoading,
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                    side: const BorderSide(color: Colors.grey),
                    icon: Image.asset(
                      'assets/icons/google.png',
                      height: 24,
                      width: 24,
                    ),
                    onPressed: () {
                      ref.read(authViewModelProvider.notifier).signInWithGoogle();
                    },
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.black54),
                      ),
                      GradientTextButton(
                        text: 'Login',
                        onPressed: () => context.goNamed(AppRouteNames.login)                   ),
                    ],
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