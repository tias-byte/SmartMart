import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/app_theme.dart';
import '../admin/widgets/admin_fleet_map.dart';
import 'widgets/rider_home_tab.dart';
import 'widgets/rider_earnings_tab.dart';
import 'widgets/rider_profile_tab.dart';
import 'widgets/rider_bottom_nav.dart';

class RiderDashboardView extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback? onLogout;

  const RiderDashboardView({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    this.onLogout,
  });

  @override
  State<RiderDashboardView> createState() => _RiderDashboardViewState();
}

class _RiderDashboardViewState extends State<RiderDashboardView> {
  int currentTab = 0;
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.bgDark : AppTheme.bgLight,
      body: Column(
        children: [
          // Responsive Top Header Bar for Rider Platform
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.bgDark : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppTheme.borderDark : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand & Title
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(LucideIcons.bike, color: Color(0xFF10B981), size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rider Portal",
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                                                  ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Center Navigation Tabs (Desktop View)
                LayoutBuilder(
                  builder: (context, constraints) {
                    return MediaQuery.of(context).size.width > 768
                        ? Row(
                            children: [
                              _navTabPill(0, "Home & Orders", LucideIcons.home),
                              const SizedBox(width: 8),
                              _navTabPill(1, "Earnings & Wallet", LucideIcons.wallet),
                              const SizedBox(width: 8),
                              _navTabPill(2, "Profile & KYC", LucideIcons.user),
                            ],
                          )
                        : const SizedBox.shrink();
                  },
                ),

                // Right Actions & Role Switcher
                Row(
                  children: [
                    // Online Duty Switcher
                    InkWell(
                      onTap: () => setState(() => isOnline = !isOnline),
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isOnline
                              ? const Color(0xFF10B981).withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isOnline
                                ? const Color(0xFF10B981).withOpacity(0.4)
                                : Colors.red.withOpacity(0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 7,
                              decoration: BoxDecoration(
                                color: isOnline ? const Color(0xFF10B981) : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isOnline ? "ON DUTY" : "OFF DUTY",
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isOnline ? const Color(0xFF10B981) : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    if (widget.onLogout != null) ...[
                      IconButton(
                        icon: const Icon(
                          LucideIcons.logOut,
                          size: 18,
                          color: AppTheme.danger,
                        ),
                        onPressed: widget.onLogout,
                        tooltip: "Sign Out of Rider Portal",
                      ),
                      const SizedBox(width: 4),
                    ],

                    IconButton(
                      icon: Icon(
                        isDark ? LucideIcons.sun : LucideIcons.moon,
                        size: 18,
                        color: isDark ? const Color(0xFFF59E0B) : const Color(0xFF475569),
                      ),
                      onPressed: widget.onToggleTheme,
                      tooltip: isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Responsive Content Area
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 900;

                if (isDesktop) {
                  // Desktop Full-Width View (Side-by-side layout)
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Workspace Column (Tab content)
                        SizedBox(
                          width: 460,
                          child: IndexedStack(
                            index: currentTab,
                            children: [
                              RiderHomeTab(isDark: isDark),
                              RiderEarningsTab(isDark: isDark),
                              RiderProfileTab(
                                isDark: isDark,
                                onLogout: widget.onLogout,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),

                        // Right Live Telemetry & Navigation Map Panel
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AdminFleetMap(isDark: isDark),
                                const SizedBox(height: 20),
                                _buildDesktopRiderMetrics(isDark),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Mobile / Small Screen View
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: IndexedStack(
                      index: currentTab,
                      children: [
                        RiderHomeTab(isDark: isDark),
                        RiderEarningsTab(isDark: isDark),
                        RiderProfileTab(
                          isDark: isDark,
                          onLogout: widget.onLogout,
                        ),
                      ],
                    ),
                    bottomNavigationBar: RiderBottomNav(
                      selectedIndex: currentTab,
                      onSelectTab: (index) => setState(() => currentTab = index),
                      isDark: isDark,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _navTabPill(int index, String label, IconData icon) {
    final bool isActive = currentTab == index;
    return InkWell(
      onTap: () => setState(() => currentTab = index),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primary : (widget.isDark ? AppTheme.cardDarkElevated : const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isActive ? Colors.white : (widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? Colors.white : (widget.isDark ? Colors.white : const Color(0xFF0F172A)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopRiderMetrics(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard(isDark: isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Live Telemetry & Fleet Operations",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "SLA SPEED 8.4 MIN",
                  style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _metricCard("Active Orders", "3 Assigned", LucideIcons.shoppingBag, AppTheme.primary, isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _metricCard("Completed Today", "14 Deliveries", LucideIcons.checkCircle2, const Color(0xFF10B981), isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _metricCard("Current Earnings", "₹1,245.00", LucideIcons.dollarSign, const Color(0xFFF59E0B), isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _metricCard("Rider Rating", "4.92 ★", LucideIcons.star, const Color(0xFF8B5CF6), isDark),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricCard(String label, String value, IconData icon, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDarkElevated : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppTheme.borderDarkActive : const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  label,
                  style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
