import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/login_view.dart';
import 'views/admin/admin_dashboard_view.dart';
import 'views/rider/rider_dashboard_view.dart';

void main() {
  runApp(const SmartMartApp());
}

class SmartMartApp extends StatefulWidget {
  const SmartMartApp({super.key});

  @override
  State<SmartMartApp> createState() => _SmartMartAppState();
}

class _SmartMartAppState extends State<SmartMartApp> {
  bool isDark = true;
  String currentRoute = "LOGIN"; // "LOGIN", "ADMIN", or "RIDER"
  String currentUserEmail = "admin@smartmart.ai";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartMart',
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      home: Scaffold(
        backgroundColor: isDark ? AppTheme.bgDark : AppTheme.bgLight,
        body: _buildActiveView(),
      ),
    );
  }

  Widget _buildActiveView() {
    switch (currentRoute) {
      case "ADMIN":
        return AdminDashboardView(
          isDark: isDark,
          onToggleTheme: () => setState(() => isDark = !isDark),
          onLogout: () => setState(() => currentRoute = "LOGIN"),
        );
      case "RIDER":
        return RiderDashboardView(
          isDark: isDark,
          onToggleTheme: () => setState(() => isDark = !isDark),
          onLogout: () => setState(() => currentRoute = "LOGIN"),
        );
      case "LOGIN":
      default:
        return LoginView(
          isDark: isDark,
          onToggleTheme: () => setState(() => isDark = !isDark),
          onLoginSuccess: (role, email) {
            setState(() {
              currentUserEmail = email;
              currentRoute = role;
            });
          },
        );
    }
  }
}
