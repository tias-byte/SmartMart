import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';

class SuperAdminQuickActions extends StatelessWidget {
  final bool isDark;
  final Function(String) onTriggerAction;

  const SuperAdminQuickActions({
    super.key,
    required this.isDark,
    required this.onTriggerAction,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'title': "Add Dark Store", 'icon': LucideIcons.store, 'color': AppTheme.secondary, 'tag': 'EXPAND'},
      {'title': "Add Product SKU", 'icon': LucideIcons.packagePlus, 'color': AppTheme.primary, 'tag': 'INVENTORY'},
      {'title': "Assign Dispatch Rider", 'icon': LucideIcons.userCheck, 'color': AppTheme.accent, 'tag': 'FLEET'},
      {'title': "Run BI Cohort Analysis", 'icon': LucideIcons.lineChart, 'color': const Color(0xFF8B5CF6), 'tag': 'ANALYTICS'},
      {'title': "Run Demand ML Forecast", 'icon': LucideIcons.brainCircuit, 'color': const Color(0xFFEC4899), 'tag': 'AI ENGINE'},
      {'title': "Export Telemetry Audit", 'icon': LucideIcons.fileSpreadsheet, 'color': const Color(0xFF10B981), 'tag': 'REPORTS'},
      {'title': "Broadcast System Alert", 'icon': LucideIcons.megaphone, 'color': AppTheme.danger, 'tag': 'ALERT'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassCard(isDark: isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Data Analyst Operations & BI Actions",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "7 BI SUITE",
                      style: GoogleFonts.inter(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.primary),
                    ),
                  ),
                ],
              ),
              Text(
                "Trigger automated ML routines & data export jobs",
                style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: actions.map((act) {
              final Color color = act['color'] as Color;
              final String title = act['title'] as String;
              final IconData icon = act['icon'] as IconData;
              final String tag = act['tag'] as String;

              return InkWell(
                onTap: () => onTriggerAction(title),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 15, color: color),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.inter(fontSize: 8.5, fontWeight: FontWeight.bold, color: isDark ? Colors.white : color),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

