import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';

class AdminKPIs extends StatelessWidget {
  final bool isDark;

  const AdminKPIs({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final kpis = [
      {
        'title': "Total Gross Sales",
        'value': QuickCommerceData.todayRevenue,
        'change': "+21.4% vs last week",
        'subText': "AOV: ${QuickCommerceData.avgOrderValue} • Margin: 24.8%",
        'isPositive': true,
        'icon': LucideIcons.indianRupee,
        'color': AppTheme.primary,
      },
      {
        'title': "Total Orders Processed",
        'value': QuickCommerceData.todayOrders,
        'change': "+18.6% vs last week",
        'subText': "Velocity: 14.2 orders/min",
        'isPositive': true,
        'icon': LucideIcons.shoppingBag,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': "Delivery SLA Adherence",
        'value': QuickCommerceData.slaAdherence,
        'change': "+2.4% SLA uplift",
        'subText': "Avg Delivery Time: ${QuickCommerceData.avgDeliveryTime}",
        'isPositive': true,
        'icon': LucideIcons.clock,
        'color': AppTheme.secondary,
      },
      {
        'title': "Active Fleet Utilization",
        'value': QuickCommerceData.activeRiders,
        'change': "88.4% On-road Duty",
        'subText': "1,245 Riders Active • 98.5% Acceptance",
        'isPositive': true,
        'icon': LucideIcons.bike,
        'color': AppTheme.accent,
      },
      {
        'title': "Customer Retention Rate",
        'value': QuickCommerceData.repeatCustomerRate,
        'change': "+5.1% Repeat Order Uplift",
        'subText': "${QuickCommerceData.newCustomers} Active Users • LTV ₹4,850",
        'isPositive': true,
        'icon': LucideIcons.userCheck,
        'color': const Color(0xFF10B981),
      },
      {
        'title': "Dark Store Operations",
        'value': QuickCommerceData.onlineStores,
        'change': "96.5% Stock Health",
        'subText': "245 Stores Online • 1.8% Stockout Risk",
        'isPositive': true,
        'icon': LucideIcons.store,
        'color': AppTheme.danger,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 1200 ? 6 : (constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 550 ? 2 : 1));
        double childAspectRatio = constraints.maxWidth > 1200 ? 1.35 : (constraints.maxWidth > 800 ? 1.9 : (constraints.maxWidth > 550 ? 1.65 : 2.55));

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: kpis.length,
          itemBuilder: (context, index) {
            final kpi = kpis[index];
            final Color iconColor = kpi['color'] as Color;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: AppTheme.glassCard(isDark: isDark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          kpi['title'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(kpi['icon'] as IconData, size: 14, color: iconColor),
                      ),
                    ],
                  ),
                  Text(
                    kpi['value'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              (kpi['isPositive'] as bool) ? LucideIcons.arrowUpRight : LucideIcons.arrowDownRight,
                              size: 13,
                              color: (kpi['isPositive'] as bool) ? AppTheme.primary : AppTheme.danger,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              kpi['change'] as String,
                              style: GoogleFonts.inter(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: (kpi['isPositive'] as bool) ? AppTheme.primary : AppTheme.danger,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        kpi['subText'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
