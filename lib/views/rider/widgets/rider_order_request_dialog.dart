import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';

class RiderOrderRequestDialog extends StatefulWidget {
  final OrderModel order;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isDark;

  const RiderOrderRequestDialog({
    super.key,
    required this.order,
    required this.onAccept,
    required this.onReject,
    required this.isDark,
  });

  @override
  State<RiderOrderRequestDialog> createState() => _RiderOrderRequestDialogState();
}

class _RiderOrderRequestDialogState extends State<RiderOrderRequestDialog> {
  int secondsRemaining = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining > 0) {
        if (mounted) setState(() => secondsRemaining--);
      } else {
        t.cancel();
        widget.onReject();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: widget.isDark ? AppTheme.cardDarkElevated : Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Banner with Timer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFEA580C), AppTheme.accent]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.zap, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "New Order Request!",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(LucideIcons.clock, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${secondsRemaining}s",
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Pickup Store Address
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(LucideIcons.store, color: AppTheme.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PICKUP FROM",
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primary),
                      ),
                      Text(
                        widget.order.storeName,
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.order.storeAddress,
                        style: GoogleFonts.inter(fontSize: 11, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 20,
                  child: VerticalDivider(thickness: 2, color: Color(0xFFCBD5E1)),
                ),
              ),
            ),

            // Delivery Destination Address
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.danger.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(LucideIcons.mapPin, color: AppTheme.danger, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DROP TO",
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.danger),
                      ),
                      Text(
                        widget.order.customerName,
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.order.customerAddress,
                        style: GoogleFonts.inter(fontSize: 11, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Payout & Distance Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("ESTIMATED EARNING", style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
                    Text("₹45", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                  ],
                ),
                Container(height: 30, width: 1, color: const Color(0xFFCBD5E1)),
                Column(
                  children: [
                    Text("DISTANCE", style: GoogleFonts.inter(fontSize: 10, color: const Color(0xFF64748B))),
                    Text(widget.order.distance, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Large One-Hand Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.danger,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: widget.onReject,
                    icon: const Icon(LucideIcons.x, size: 18),
                    label: Text("Reject", style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: widget.onAccept,
                    icon: const Icon(LucideIcons.check, size: 18),
                    label: Text("Accept", style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
