import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';

class AdminCharts extends StatefulWidget {
  final bool isDark;

  const AdminCharts({super.key, required this.isDark});

  @override
  State<AdminCharts> createState() => _AdminChartsState();
}

class _AdminChartsState extends State<AdminCharts> {
  String? _selectedMetric;
  String get selectedMetric => _selectedMetric ?? "Orders";

  @override
  void initState() {
    super.initState();
    _selectedMetric = "Orders";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Widget hourlyCard = Container(
          height: 360,
          padding: const EdgeInsets.all(20),
          decoration: AppTheme.glassCard(isDark: widget.isDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Hourly Dispatch & Load Analytics",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.bold,
                                  color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
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
                                "24H",
                                style: GoogleFonts.inter(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.primary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 16,
                          runSpacing: 4,
                          children: [
                            _legendItem("Orders Velocity", AppTheme.primary),
                            _legendItem("Fleet Active", const Color(0xFF8B5CF6)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: ["Orders", "Revenue"].map((m) {
                      final bool isActive = selectedMetric == m;
                      return Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: InkWell(
                          onTap: () => setState(() => _selectedMetric = m),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.primary
                                  : (widget.isDark ? AppTheme.cardDarkElevated : const Color(0xFFF1F5F9)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              m,
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                                color: isActive ? Colors.white : (widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: HourlyAnalyticsPainter(isDark: widget.isDark, isRevenue: selectedMetric == "Revenue"),
                ),
              ),
            ],
          ),
        );

        final Widget slaCard = Container(
          height: 360,
          padding: const EdgeInsets.all(20),
          decoration: AppTheme.glassCard(isDark: widget.isDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Time SLA Distribution",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              Text(
                "Fulfillment Target: < 10 mins (94.8% SLA)",
                style: GoogleFonts.inter(fontSize: 11, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: SlaDonutPainter(isDark: widget.isDark),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: QuickCommerceData.slaDistribution.map((sla) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: _donutLegend(
                              sla.range,
                              "${sla.count} (${sla.percentage}%)",
                              Color(sla.color),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        final Widget categoryCard = Container(
          height: 360,
          padding: const EdgeInsets.all(20),
          decoration: AppTheme.glassCard(isDark: widget.isDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Category Share Analytics",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "Gross Revenue",
                    style: GoogleFonts.inter(fontSize: 10.5, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: QuickCommerceData.categoryAnalytics.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final cat = QuickCommerceData.categoryAnalytics[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                cat.name,
                                style: GoogleFonts.inter(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              cat.revenue,
                              style: GoogleFonts.inter(fontSize: 11.5, fontWeight: FontWeight.bold, color: AppTheme.primary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: cat.share / 100,
                            minHeight: 6,
                            backgroundColor: widget.isDark ? AppTheme.borderDark : const Color(0xFFE2E8F0),
                            color: index == 0 ? AppTheme.primary : (index == 1 ? AppTheme.secondary : (index == 2 ? const Color(0xFF8B5CF6) : AppTheme.accent)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );

        final isLargeDesktop = constraints.maxWidth > 1200;
        final isMediumDesktop = constraints.maxWidth > 800 && constraints.maxWidth <= 1200;

        if (isLargeDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 6, child: hourlyCard),
              const SizedBox(width: 16),
              Expanded(flex: 3, child: slaCard),
              const SizedBox(width: 16),
              Expanded(flex: 3, child: categoryCard),
            ],
          );
        } else if (isMediumDesktop) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hourlyCard,
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: slaCard),
                  const SizedBox(width: 16),
                  Expanded(child: categoryCard),
                ],
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hourlyCard,
              const SizedBox(height: 16),
              slaCard,
              const SizedBox(height: 16),
              categoryCard,
            ],
          );
        }
      },
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 11.5, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _donutLegend(String title, String subtitle, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(fontSize: 9.5, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Painter for Hourly Analytics Curve
class HourlyAnalyticsPainter extends CustomPainter {
  final bool isDark;
  final bool isRevenue;

  HourlyAnalyticsPainter({required this.isDark, required this.isRevenue});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)
      ..strokeWidth = 1;

    // Grid lines
    const int lines = 4;
    for (int i = 0; i <= lines; i++) {
      double y = size.height * (i / lines);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final data = QuickCommerceData.hourlyAnalytics;
    double maxVal = isRevenue ? 600000.0 : 2500.0;

    final points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      double x = (size.width / (data.length - 1)) * i;
      double val = isRevenue ? data[i].revenue : data[i].orders.toDouble();
      double y = size.height - ((val / maxVal) * size.height * 0.85);
      points.add(Offset(x, y));
    }

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }

    final areaPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppTheme.primary.withOpacity(0.35),
        AppTheme.primary.withOpacity(0.0),
      ],
    );

    canvas.drawPath(areaPath, Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
    canvas.drawPath(path, Paint()..color = AppTheme.primary..strokeWidth = 3..style = PaintingStyle.stroke);

    // Draw dots & peak highlights
    for (int i = 0; i < points.length; i++) {
      final p = points[i];
      bool isPeak = (i == 4 || i == 7 || i == 10);
      canvas.drawCircle(p, isPeak ? 6 : 4, Paint()..color = isPeak ? const Color(0xFF8B5CF6) : AppTheme.primary);
      canvas.drawCircle(p, isPeak ? 3 : 2, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for SLA Donut
class SlaDonutPainter extends CustomPainter {
  final bool isDark;

  SlaDonutPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 10;

    final slices = QuickCommerceData.slaDistribution;
    double startAngle = -pi / 2;

    for (var slice in slices) {
      final sweepAngle = (slice.percentage / 100) * 2 * pi;
      final paint = Paint()
        ..color = Color(slice.color)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + 0.04,
        sweepAngle - 0.08,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }

    // Inner circle background
    final centerPaint = Paint()..color = isDark ? const Color(0xFF1E293B) : Colors.white;
    canvas.drawCircle(center, radius - 18, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
