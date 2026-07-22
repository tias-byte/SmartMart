import 'package:flutter/material.dart';
import 'package:smartcart/screens/admin/admin_shell.dart';
import 'package:smartcart/screens/auth/login_screen.dart';
import 'package:smartcart/screens/main_shell.dart';
import 'package:smartcart/state/auth_controller.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: authController,
      builder: (context, _) {
        if (!authController.isLoggedIn) {
          return const LoginScreen();
        }
        if (authController.isAdmin) {
          return const AdminShell();
        }
        return const MainShell();
      },
    );
  }
}
