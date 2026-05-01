import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/provider/auth_viewmodel_provider.dart';

class AuthLoadingOverlay extends ConsumerWidget {
  const AuthLoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading =
    ref.watch(authViewModelProvider.select((s) => s.loading));

    if (!loading) return const SizedBox();

    return Container(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }
}