import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';

class RiderBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelectTab;
  final bool isDark;

  const RiderBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelectTab,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': "Home", 'icon': LucideIcons.home},
      {'label': "Earnings", 'icon': LucideIcons.wallet},
      {'label': "Profile", 'icon': LucideIcons.user},
    ];

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.bgDark : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppTheme.borderDark : const Color(0xFFE2E8F0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final bool isActive = selectedIndex == index;
          final IconData icon = item['icon'] as IconData;
          final String label = item['label'] as String;

          return InkWell(
            onTap: () => onSelectTab(index),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: isActive ? AppTheme.primary : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 10.5,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive ? AppTheme.primary : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
