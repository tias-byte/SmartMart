import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';
import 'rider_order_request_dialog.dart';
import 'rider_otp_dialog.dart';

class RiderHomeTab extends StatefulWidget {
  final bool isDark;

  const RiderHomeTab({super.key, required this.isDark});

  @override
  State<RiderHomeTab> createState() => _RiderHomeTabState();
}

class _RiderHomeTabState extends State<RiderHomeTab> {
  bool isOnline = true;
  OrderModel? activeOrder;
  int currentStep = 0; // 0: Assigned, 1: Picked Up, 2: Delivery Verified

  @override
  void initState() {
    super.initState();
    // Default set an active order for demo
    activeOrder = QuickCommerceData.recentOrders.first;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rider Header Greeting & Online Switcher
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.glassCard(isDark: widget.isDark),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200"),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning,",
                          style: GoogleFonts.inter(fontSize: 11, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                        ),
                        Text(
                          "Rohan Kumar",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => setState(() => isOnline = !isOnline),
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isOnline ? AppTheme.primary : const Color(0xFF64748B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isOnline ? "Online" : "Offline",
                          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Today's Earnings Summary Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF047857), AppTheme.primary],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: AppTheme.primary.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today's Earning", style: GoogleFonts.inter(fontSize: 12, color: Colors.white70)),
                    Text(
                      QuickCommerceData.currentRiderEarnings.todayEarnings,
                      style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "${QuickCommerceData.currentRiderEarnings.completedOrders} Orders Completed",
                      style: GoogleFonts.inter(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text("4.8", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Simulate Incoming Order Request Button
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              side: BorderSide(color: AppTheme.accent),
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return RiderOrderRequestDialog(
                    order: QuickCommerceData.recentOrders[1],
                    isDark: widget.isDark,
                    onAccept: () {
                      Navigator.pop(context);
                      setState(() {
                        activeOrder = QuickCommerceData.recentOrders[1];
                        currentStep = 0;
                      });
                    },
                    onReject: () => Navigator.pop(context),
                  );
                },
              );
            },
            icon: const Icon(LucideIcons.bellRing, size: 16, color: AppTheme.accent),
            label: Text(
              "Simulate Incoming Order Request",
              style: GoogleFonts.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.accent),
            ),
          ),
          const SizedBox(height: 16),

          // Active Order Section
          if (activeOrder != null) ...[
            Text(
              "Active Delivery Stream",
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: AppTheme.glassCard(isDark: widget.isDark, accentBorderColor: AppTheme.primary.withOpacity(0.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ${activeOrder!.id}",
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.primary),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          currentStep == 0 ? "At Store" : (currentStep == 1 ? "In Transit" : "Delivered"),
                          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Map Preview Canvas
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.isDark ? AppTheme.cardDark : const Color(0xFFEBF1F5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(painter: RiderRoutePainter(isDark: widget.isDark)),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.navigation, color: Colors.white, size: 14),
                                const SizedBox(width: 4),
                                Text("Navigate", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Customer & Store Details
                  Text("Customer: ${activeOrder!.customerName}", style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(activeOrder!.customerAddress, style: GoogleFonts.inter(fontSize: 11.5, color: const Color(0xFF64748B))),
                  const SizedBox(height: 14),

                  // Contact Customer / Chat Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.phone, size: 16, color: AppTheme.accent),
                          label: Text("Call", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.accent)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.messageSquare, size: 16, color: AppTheme.primary),
                          label: Text("Chat", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Step Action Button
                  if (currentStep == 0)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 46),
                        backgroundColor: AppTheme.accent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => RiderOtpDialog(
                            title: "Verify Pickup OTP",
                            correctOtp: activeOrder!.pickupOtp,
                            isDark: widget.isDark,
                            onSuccess: () => setState(() => currentStep = 1),
                          ),
                        );
                      },
                      icon: const Icon(LucideIcons.packageCheck, size: 18),
                      label: Text("Enter Pickup OTP (${activeOrder!.pickupOtp})", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                    )
                  else if (currentStep == 1)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 46),
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => RiderOtpDialog(
                            title: "Verify Delivery OTP",
                            correctOtp: activeOrder!.deliveryOtp,
                            isDark: widget.isDark,
                            onSuccess: () {
                              setState(() => currentStep = 2);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Order Delivered Successfully! +₹45 Earned"), backgroundColor: AppTheme.primary),
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(LucideIcons.checkCircle2, size: 18),
                      label: Text("Enter Delivery OTP (${activeOrder!.deliveryOtp})", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Order Completed 🎉", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class RiderRoutePainter extends CustomPainter {
  final bool isDark;

  RiderRoutePainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.15, size.height * 0.7);
    path.lineTo(size.width * 0.45, size.height * 0.7);
    path.lineTo(size.width * 0.45, size.height * 0.3);
    path.lineTo(size.width * 0.85, size.height * 0.3);

    final linePaint = Paint()
      ..color = AppTheme.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    // Store Pin
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.7), 8, Paint()..color = AppTheme.primary);
    // Drop Pin
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.3), 8, Paint()..color = AppTheme.danger);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
