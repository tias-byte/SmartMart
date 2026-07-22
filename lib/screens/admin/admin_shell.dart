import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcart/data/app_data.dart';
import 'package:smartcart/screens/admin/admin_dashboard_screen.dart';
import 'package:smartcart/state/auth_controller.dart';
import 'package:smartcart/state/cart_controller.dart';
import 'package:smartcart/theme/app_colors.dart';
import 'package:smartcart/theme/app_theme.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = const [
      AdminDashboardScreen(),
      AdminOrdersScreen(),
      AdminProductsScreen(),
      AdminUsersScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.primary.withValues(alpha: 0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics_rounded),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Users',
          ),
        ],
      ),
    );
  }
}

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  static const _orders = [
    ('#SC1024', 'Pending', '₹420', 'Old Dhatia Falia'),
    ('#SC1023', 'Out for delivery', '₹189', 'Railway Station Road'),
    ('#SC1022', 'Delivered', '₹760', 'City Center'),
    ('#SC1021', 'Cancelled', '₹99', 'Market Yard'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Orders',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final order = _orders[index];
          final statusColor = switch (order.$2) {
            'Pending' => AppTheme.accent,
            'Out for delivery' => AppTheme.secondary,
            'Delivered' => AppTheme.success,
            _ => AppTheme.danger,
          };
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: AppTheme.glassCard(isDark: false, radius: 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.$1,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.$4,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      order.$3,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.$2,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = AppData.allProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Products',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppTheme.borderLight),
            ),
            tileColor: Colors.white,
            leading: CircleAvatar(
              backgroundColor: product.color.withValues(alpha: 0.15),
              child: Icon(product.icon, color: product.color),
            ),
            title: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('In stock'),
            trailing: Text(
              product.price,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppTheme.primary,
              ),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Manage ${product.name}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  static const _users = [
    ('Aarav Patel', 'aarav@email.com', 'Active'),
    ('Neha Sharma', 'neha@email.com', 'Active'),
    ('Rohan Das', 'rohan@email.com', 'Blocked'),
    ('Priya Singh', 'priya@email.com', 'Active'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Users',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cartController.clear();
              authController.logout();
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final user = _users[index];
          final active = user.$3 == 'Active';
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppTheme.borderLight),
            ),
            tileColor: Colors.white,
            leading: CircleAvatar(
              backgroundColor: AppTheme.secondary.withValues(alpha: 0.12),
              child: Text(
                user.$1.substring(0, 1),
                style: const TextStyle(
                  color: AppTheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(
              user.$1,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(user.$2),
            trailing: Text(
              user.$3,
              style: TextStyle(
                color: active ? AppTheme.success : AppTheme.danger,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
