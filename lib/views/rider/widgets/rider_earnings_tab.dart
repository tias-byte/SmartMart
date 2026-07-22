import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';

class RiderEarningsTab extends StatefulWidget {
  final bool isDark;

  const RiderEarningsTab({super.key, required this.isDark});

  @override
  State<RiderEarningsTab> createState() => _RiderEarningsTabState();
}

class _RiderEarningsTabState extends State<RiderEarningsTab> {
  String activePeriod = "Daily";

  @override
  Widget build(BuildContext context) {
    final earningsData = QuickCommerceData.currentRiderEarnings;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Selector Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Earnings & Rewards",
                  style: GoogleFonts.poppins(fontSize: 16.5, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: ["Daily", "Weekly", "Monthly"].map((period) {
                  final bool isActive = activePeriod == period;
                  return Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: InkWell(
                      onTap: () => setState(() => activePeriod = period),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isActive ? AppTheme.primary : (widget.isDark ? AppTheme.cardDarkElevated : const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          period,
                          style: GoogleFonts.inter(fontSize: 10.5, fontWeight: FontWeight.bold, color: isActive ? Colors.white : null),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Total Earnings Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassCard(isDark: widget.isDark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Earnings ($activePeriod)", style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                const SizedBox(height: 4),
                Text(
                  activePeriod == "Daily" ? earningsData.todayEarnings : (activePeriod == "Weekly" ? earningsData.totalWeeklyEarnings : earningsData.monthlyEarnings),
                  style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primary),
                ),
                const SizedBox(height: 16),

                // Breakdown list
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _earningSubItem("Order Pay", "₹980", widget.isDark),
                    _earningSubItem("Incentives", "₹200", widget.isDark),
                    _earningSubItem("Tips", "₹65", widget.isDark),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Daily Incentive Goal Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.glassCard(isDark: widget.isDark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.trophy, color: AppTheme.accent, size: 18),
                        const SizedBox(width: 8),
                        Text("Daily Target Incentive", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text("6/8 Orders", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                  ],
                ),
                const SizedBox(height: 10),

                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 6 / 8,
                    minHeight: 10,
                    backgroundColor: widget.isDark ? AppTheme.borderDarkActive : const Color(0xFFE2E8F0),
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Complete 2 more orders to unlock +₹200 bonus reward!",
                  style: GoogleFonts.inter(fontSize: 11, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _earningSubItem(String label, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
        Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
