
import 'package:flutter/cupertino.dart';
import 'package:fluxiq/features/auth/screens/new%20password/listeners/resent_new_password.dart';

import '../../../../../core/listeners/auth_listeners.dart';


class NewPasswordListeners extends StatelessWidget {
  final Widget child;

  const NewPasswordListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AuthListeners(
      child: ResentNewPasswordListeners(
        child: child,
      ),
    );
  }
}