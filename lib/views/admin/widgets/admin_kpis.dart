import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class AdminKPIs extends StatelessWidget {
  final bool isDark;

  const AdminKPIs({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final kpis = [
      {
        'title': "Store Gross Sales Today",
        'value': "₹84,520",
        'change': "+15.4% vs last week",
        'subText': "AOV: ₹340 • Margin: 24.8%",
        'isPositive': true,
        'icon': LucideIcons.indianRupee,
        'color': AppTheme.primary,
      },
      {
        'title': "Store Orders Processed",
        'value': "248",
        'change': "+12.6% vs last week",
        'subText': "Velocity: 2.1 orders/min",
        'isPositive': true,
        'icon': LucideIcons.shoppingBag,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': "Delivery SLA Adherence",
        'value': "98.4%",
        'change': "+1.2% SLA uplift",
        'subText': "Avg Local Delivery Time: 11.2 mins",
        'isPositive': true,
        'icon': LucideIcons.clock,
        'color': AppTheme.secondary,
      },
      {
        'title': "Active Local Fleet",
        'value': "8 / 10",
        'change': "100% SLA compliance",
        'subText': "8 on-duty riders • 2 on break",
        'isPositive': true,
        'icon': LucideIcons.bike,
        'color': AppTheme.accent,
      },
      {
        'title': "Customer Retention Rate",
        'value': "72.4%",
        'change': "+3.4% Repeat Order Uplift",
        'subText': "180 Active Users • Avg LTV ₹4,850",
        'isPositive': true,
        'icon': LucideIcons.userCheck,
        'color': const Color(0xFF10B981),
      },
      {
        'title': "Local Store Stock Health",
        'value': "98.2%",
        'change': "12 SKUs Low Stock",
        'subText': "Next replenishment batch at 4:00 PM",
        'isPositive': true,
        'icon': LucideIcons.store,
        'color': AppTheme.danger,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 1200 ? 6 : (constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 550 ? 2 : 1));
        double cardWidth = (constraints.maxWidth - (crossAxisCount - 1) * 14) / crossAxisCount;
        if (cardWidth < 120) cardWidth = 120;

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: kpis.map((kpi) {
            final Color iconColor = kpi['color'] as Color;
            return SizedBox(
              width: cardWidth,
              height: 130,
              child: Container(
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
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
