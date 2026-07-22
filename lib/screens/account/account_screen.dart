import 'package:flutter/material.dart';
import 'package:smartcart/screens/cart/cart_screen.dart';
import 'package:smartcart/screens/profile/profile_screen.dart';
import 'package:smartcart/state/auth_controller.dart';
import 'package:smartcart/state/cart_controller.dart';
import 'package:smartcart/theme/app_colors.dart';
import 'package:smartcart/theme/app_theme.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser;

    final items = <(IconData, String, VoidCallback)>[
      (
        Icons.person_outline,
        'My Profile',
        () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        },
      ),
      (
        Icons.shopping_bag_outlined,
        'My Cart',
        () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CartScreen()),
          );
        },
      ),
      (
        Icons.receipt_long_outlined,
        'My Orders',
        () => _toast(context, 'Orders history opening soon'),
      ),
      (
        Icons.favorite_border,
        'Wishlist',
        () => _toast(context, 'Wishlist opened'),
      ),
      (
        Icons.location_on_outlined,
        'Saved Addresses',
        () => _toast(context, 'Addresses opened'),
      ),
      (
        Icons.payment_outlined,
        'Payment Methods',
        () => _toast(context, 'Payments opened'),
      ),
      (
        Icons.help_outline,
        'Help & Support',
        () => _toast(context, 'Support chat opened'),
      ),
      (
        Icons.settings_outlined,
        'Settings',
        () => _toast(context, 'Settings opened'),
      ),
      (
        Icons.logout_rounded,
        'Logout',
        () {
          cartController.clear();
          authController.logout();
        },
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Account',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListenableBuilder(
            listenable: cartController,
            builder: (context, _) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'SmartMart User',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user?.email ?? '',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Role: ${user?.roleLabel ?? 'User'}',
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (cartController.totalCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${cartController.totalCount} in cart',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                onTap: item.$3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.cardBorder),
                ),
                tileColor: Colors.white,
                leading: Icon(
                  item.$1,
                  color: item.$2 == 'Logout'
                      ? AppTheme.danger
                      : AppColors.primary,
                ),
                title: Text(
                  item.$2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: item.$2 == 'Logout' ? AppTheme.danger : null,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }
}
