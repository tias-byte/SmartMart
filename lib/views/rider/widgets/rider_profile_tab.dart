import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';

class RiderProfileTab extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onLogout;

  const RiderProfileTab({
    super.key,
    required this.isDark,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final rider = QuickCommerceData.currentRiderEarnings;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Avatar & Name Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassCard(isDark: isDark),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage("https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200"),
                ),
                const SizedBox(height: 12),
                Text(rider.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text("${rider.rating} Rating", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Text("• ${rider.vehicleType}", style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Instant Wallet Payout Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.cardDarkElevated, AppTheme.cardDark]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Wallet Balance", style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
                    Text("₹1,245.00", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Instant Payout Initiated! ₹1,245 sent to bank"), backgroundColor: AppTheme.primary),
                    );
                  },
                  icon: const Icon(LucideIcons.arrowUpRight, size: 16),
                  label: Text("Withdraw", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Verified Documents & Vehicle Options
          _profileOptionTile(LucideIcons.bike, "Vehicle Details", rider.vehicleNumber, isDark),
          _profileOptionTile(LucideIcons.fileCheck, "KYC & Documents", "Verified (DL, Aadhaar, RC)", isDark),
          _profileOptionTile(LucideIcons.building2, "Bank Account", "HDFC Bank (•••• 4821)", isDark),
          _profileOptionTile(LucideIcons.headphones, "Help Center & Support", "24/7 Rider Hotline", isDark),
          _profileOptionTile(LucideIcons.settings, "Settings & Preferences", "App language, alerts", isDark),
          const SizedBox(height: 16),

          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              side: const BorderSide(color: AppTheme.danger),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onLogout,
            icon: const Icon(LucideIcons.logOut, size: 16, color: AppTheme.danger),
            label: Text("Logout", style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.danger)),
          ),
        ],
      ),
    );
  }

  Widget _profileOptionTile(IconData icon, String title, String subtitle, bool isDark, {bool isHighlight = false}) {
    final tileColor = isHighlight ? AppTheme.primary : (isDark ? Colors.white : Colors.black);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: isHighlight
          ? BoxDecoration(
              color: AppTheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.primary.withOpacity(0.4)),
            )
          : AppTheme.glassCard(isDark: isDark),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isHighlight ? AppTheme.primary : AppTheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: isHighlight ? Colors.white : AppTheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isHighlight ? tileColor : null)),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 11, color: isHighlight ? AppTheme.primary : const Color(0xFF64748B))),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, size: 16, color: isHighlight ? AppTheme.primary : const Color(0xFF64748B)),
        ],
      ),
    );
  }
}
