import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';

class AdminFleetMap extends StatelessWidget {
  final bool isDark;

  const AdminFleetMap({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1100;
        return Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Fleet & Zone Heatmap Container
            Expanded(
              flex: isDesktop ? 7 : 0,
              child: Container(
                height: 320,
                decoration: AppTheme.glassCard(isDark: isDark),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: MapCanvasPainter(isDark: isDark),
                        ),
                      ),
                      // Overlay Telemetry Header & Stats
                      Positioned(
                        left: 16,
                        right: 16,
                        top: 16,
                        child: LayoutBuilder(
                          builder: (context, mapHeaderConstraints) {
                            final bool isNarrow = mapHeaderConstraints.maxWidth < 620;
                            if (isNarrow) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: (isDark ? const Color(0xFF0F172A) : Colors.white).withOpacity(0.95),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: AppTheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            "Live Fleet & Dispatch (1,245 Active)",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "Route Efficiency: 97.8%",
                                      style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: (isDark ? const Color(0xFF0F172A) : Colors.white).withOpacity(0.95),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: AppTheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Live Fleet & Dispatch Heatmap (1,245 Active • 88.4% Duty)",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Route Efficiency: 97.8%",
                                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),

            // Live Rider Activity Feed & Telemetry Panel
            Expanded(
              flex: isDesktop ? 5 : 0,
              child: Container(
                height: 320,
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.glassCard(isDark: isDark),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Rider Telemetry Stream",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "GPS 1Hz",
                                  style: GoogleFonts.inter(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Avg Dispatch: 1.4m",
                          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.separated(
                        itemCount: 4,
                        separatorBuilder: (context, index) => const Divider(height: 12, color: Color(0xFF1E293B)),
                        itemBuilder: (context, index) {
                          final riderNames = ["Rohan Kumar", "Saurav Das", "Amit Shaw", "Bikash Mondal"];
                          final orders = ["#ORD125487", "#ORD125486", "#ORD125485", "#ORD125484"];
                          final statuses = ["In Transit (7.2m)", "In Transit (9.5m)", "Dispatched", "Delivered (6.8m)"];

                          return Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: AppTheme.secondary,
                                child: Icon(LucideIcons.bike, size: 14, color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      riderNames[index],
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold,
                                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                                      ),
                                    ),
                                    Text(
                                      "Order ${orders[index]} • Sector 5 Dark Store",
                                      style: GoogleFonts.inter(fontSize: 10.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  statuses[index],
                                  style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.secondary),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Custom Painter for Map View
class MapCanvasPainter extends CustomPainter {
  final bool isDark;

  MapCanvasPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    // Background Grid simulating map streets
    final bgPaint = Paint()..color = isDark ? const Color(0xFF0B132B) : const Color(0xFFEBF1F5);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF1C2541).withOpacity(0.8) : Colors.white
      ..strokeWidth = 14;

    // Draw main arterial roads
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.75), Offset(size.width, size.height * 0.75), roadPaint);
    canvas.drawLine(Offset(size.width * 0.35, 0), Offset(size.width * 0.35, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), roadPaint);

    // Active Delivery Route Line (Dotted / Glowing Green)
    final routePath = Path();
    routePath.moveTo(size.width * 0.35, size.height * 0.4);
    routePath.lineTo(size.width * 0.52, size.height * 0.4);
    routePath.lineTo(size.width * 0.52, size.height * 0.75);
    routePath.lineTo(size.width * 0.7, size.height * 0.75);

    final routePaint = Paint()
      ..color = AppTheme.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawPath(routePath, routePaint);

    // Store Hub Marker (Green Pin)
    final storePos = Offset(size.width * 0.35, size.height * 0.4);
    canvas.drawCircle(storePos, 14, Paint()..color = AppTheme.primary.withOpacity(0.3));
    canvas.drawCircle(storePos, 8, Paint()..color = AppTheme.primary);

    // Customer Destination Pin (Red Pin)
    final destPos = Offset(size.width * 0.7, size.height * 0.75);
    canvas.drawCircle(destPos, 14, Paint()..color = AppTheme.danger.withOpacity(0.3));
    canvas.drawCircle(destPos, 8, Paint()..color = AppTheme.danger);

    // Rider Moving Pin (Blue Bike Pin)
    final riderPos = Offset(size.width * 0.52, size.height * 0.58);
    canvas.drawCircle(riderPos, 16, Paint()..color = AppTheme.secondary.withOpacity(0.3));
    canvas.drawCircle(riderPos, 10, Paint()..color = AppTheme.secondary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
