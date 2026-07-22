import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcart/data/admin_analytics.dart';
import 'package:smartcart/state/auth_controller.dart';
import 'package:smartcart/state/cart_controller.dart';
import 'package:smartcart/theme/app_colors.dart';
import 'package:smartcart/theme/app_theme.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = authController.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Command Center',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Text(
              'Live ops · ${user?.email ?? 'admin'}',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh insights',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Insights refreshed from last 7 days'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              cartController.clear();
              authController.logout();
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          _ExecutiveHeader(
            revenue: AdminAnalyticsData.totalRevenue,
            orders: AdminAnalyticsData.totalOrders,
            aov: AdminAnalyticsData.avgOrderValue,
            growth: AdminAnalyticsData.wowGrowth,
          ),
          const SizedBox(height: 14),
          const _KpiGrid(),
          const SizedBox(height: 16),
          const _SectionTitle(
            title: 'Revenue trajectory',
            subtitle: '7-day GMV with order volume overlay',
          ),
          const SizedBox(height: 10),
          const _RevenueTrendCard(),
          const SizedBox(height: 16),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _OrderStatusDonut()),
              SizedBox(width: 12),
              Expanded(child: _SlaGaugeCard()),
            ],
          ),
          const SizedBox(height: 16),
          const _SectionTitle(
            title: 'Category mix',
            subtitle: 'Share of GMV by vertical',
          ),
          const SizedBox(height: 10),
          const _CategoryBarCard(),
          const SizedBox(height: 16),
          const _SectionTitle(
            title: 'Demand heatmap',
            subtitle: 'Orders by hour of day (0–23)',
          ),
          const SizedBox(height: 10),
          const _HourlyHeatmap(),
          const SizedBox(height: 16),
          const _SectionTitle(
            title: 'Conversion funnel',
            subtitle: 'Drop-off from open → paid',
          ),
          const SizedBox(height: 10),
          const _FunnelCard(),
          const SizedBox(height: 16),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _RadarHealthCard()),
              SizedBox(width: 12),
              Expanded(child: _CohortMiniCard()),
            ],
          ),
          const SizedBox(height: 16),
          const _SectionTitle(
            title: 'SKU velocity leaders',
            subtitle: 'Units sold · normalized score',
          ),
          const SizedBox(height: 10),
          const _TopSkuCard(),
          const SizedBox(height: 16),
          const _InsightStrip(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child, this.padding = const EdgeInsets.all(14)});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: AppTheme.glassCard(isDark: false, radius: 16),
      child: child,
    );
  }
}

class _ExecutiveHeader extends StatelessWidget {
  const _ExecutiveHeader({
    required this.revenue,
    required this.orders,
    required this.aov,
    required this.growth,
  });

  final double revenue;
  final int orders;
  final double aov;
  final double growth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F766E), AppTheme.primary, Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Weekly performance brief',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  growth >= 0
                      ? '▲ ${growth.toStringAsFixed(1)}% WoW'
                      : '▼ ${growth.abs().toStringAsFixed(1)}% WoW',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _HeaderMetric(label: 'GMV', value: '₹${revenue.toStringAsFixed(1)}k'),
              _HeaderMetric(label: 'Orders', value: '$orders'),
              _HeaderMetric(label: 'AOV', value: '₹${aov.toStringAsFixed(0)}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  const _HeaderMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 11,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.45,
      children: [
        _SparkKpi(
          title: 'Revenue',
          value: '₹${AdminAnalyticsData.totalRevenue.toStringAsFixed(1)}k',
          delta: '+12.4%',
          color: AppTheme.primary,
          spots: AdminAnalyticsData.revenueByDay,
        ),
        _SparkKpi(
          title: 'Orders',
          value: '${AdminAnalyticsData.totalOrders}',
          delta: '+8.1%',
          color: AppTheme.secondary,
          spots: AdminAnalyticsData.ordersByDay
              .map((e) => e.toDouble())
              .toList(),
        ),
        _SparkKpi(
          title: 'AOV',
          value: '₹${AdminAnalyticsData.avgOrderValue.toStringAsFixed(0)}',
          delta: '-2.3%',
          color: AppTheme.accent,
          spots: AdminAnalyticsData.aovByDay.map((e) => e.toDouble()).toList(),
          positive: false,
        ),
        _SparkKpi(
          title: 'Volatility σ',
          value: AdminAnalyticsData.stdDev(AdminAnalyticsData.ordersByDay)
              .toStringAsFixed(1),
          delta: 'stable',
          color: const Color(0xFF8B5CF6),
          spots: AdminAnalyticsData.ordersByDay
              .map((e) => e.toDouble())
              .toList(),
          positive: true,
        ),
      ],
    );
  }
}

class _SparkKpi extends StatelessWidget {
  const _SparkKpi({
    required this.title,
    required this.value,
    required this.delta,
    required this.color,
    required this.spots,
    this.positive = true,
  });

  final String title;
  final String value;
  final String delta;
  final Color color;
  final List<double> spots;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
              Text(
                delta,
                style: TextStyle(
                  color: positive ? AppTheme.success : AppTheme.danger,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: LineChart(
              LineChartData(
                minY: spots.reduce((a, b) => a < b ? a : b) * 0.9,
                maxY: spots.reduce((a, b) => a > b ? a : b) * 1.05,
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < spots.length; i++)
                        FlSpot(i.toDouble(), spots[i]),
                    ],
                    isCurved: true,
                    color: color,
                    barWidth: 2.2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueTrendCard extends StatelessWidget {
  const _RevenueTrendCard();

  @override
  Widget build(BuildContext context) {
    final revenue = AdminAnalyticsData.revenueByDay;
    final orders = AdminAnalyticsData.ordersByDay;

    return _Panel(
      child: SizedBox(
        height: 220,
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 70,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => FlLine(
                color: AppTheme.borderLight,
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) {
                    if (value % 20 != 0) return const SizedBox.shrink();
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 34,
                  getTitlesWidget: (value, meta) {
                    if (value % 5 != 0 || value > 15) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      '₹${value.toInt()}k',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.primary,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (i < 0 || i > 6) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        AdminAnalyticsData.weekLabels[i],
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  for (var i = 0; i < revenue.length; i++)
                    FlSpot(i.toDouble(), revenue[i]),
                ],
                isCurved: true,
                color: AppTheme.primary,
                barWidth: 3,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, index) =>
                      FlDotCirclePainter(
                    radius: 3.5,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: AppTheme.primary,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primary.withValues(alpha: 0.28),
                      AppTheme.primary.withValues(alpha: 0.02),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              LineChartBarData(
                spots: [
                  for (var i = 0; i < orders.length; i++)
                    FlSpot(i.toDouble(), orders[i].toDouble()),
                ],
                isCurved: true,
                color: AppTheme.secondary,
                barWidth: 2.5,
                dashArray: [6, 4],
                dotData: const FlDotData(show: false),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touched) => touched.map((t) {
                  final isRevenue = t.barIndex == 0;
                  return LineTooltipItem(
                    isRevenue
                        ? 'GMV ₹${t.y.toStringAsFixed(1)}k'
                        : 'Orders ${t.y.toInt()}',
                    TextStyle(
                      color: isRevenue ? AppTheme.primary : AppTheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderStatusDonut extends StatelessWidget {
  const _OrderStatusDonut();

  @override
  Widget build(BuildContext context) {
    final slices = AdminAnalyticsData.orderStatus;

    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order status',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 28,
                sections: [
                  for (final s in slices)
                    PieChartSectionData(
                      value: s.$2,
                      color: s.$3,
                      radius: 34,
                      title: '${s.$2.toInt()}%',
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final s in slices)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: s.$3,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      s.$1,
                      style: const TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SlaGaugeCard extends StatelessWidget {
  const _SlaGaugeCard();

  @override
  Widget build(BuildContext context) {
    final sla = AdminAnalyticsData.deliverySla;

    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery SLA',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    startDegreeOffset: 180,
                    sectionsSpace: 0,
                    centerSpaceRadius: 36,
                    sections: [
                      PieChartSectionData(
                        value: sla * 100,
                        color: AppTheme.primary,
                        radius: 16,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: (1 - sla) * 100,
                        color: AppTheme.borderLight,
                        radius: 16,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 100,
                        color: Colors.transparent,
                        radius: 16,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(sla * 100).toStringAsFixed(0)}%',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                    const Text(
                      'on-time',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Promise window ≤ 15 min',
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          _MiniMetric(label: 'Fill rate', value: AdminAnalyticsData.fillRate),
          _MiniMetric(label: 'Stock health', value: AdminAnalyticsData.stockHealth),
          _MiniMetric(label: 'NPS index', value: AdminAnalyticsData.npsScore),
        ],
      ),
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label, style: const TextStyle(fontSize: 10)),
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 5,
              backgroundColor: AppTheme.borderLight,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBarCard extends StatelessWidget {
  const _CategoryBarCard();

  @override
  Widget build(BuildContext context) {
    final cats = AdminAnalyticsData.categorySales;

    return _Panel(
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            maxY: 45,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (v) => FlLine(
                color: AppTheme.borderLight,
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: (v, m) {
                    if (v % 10 != 0) return const SizedBox.shrink();
                    return Text(
                      '${v.toInt()}%',
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (v, m) {
                    final i = v.toInt();
                    if (i < 0 || i >= cats.length) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        cats[i].$1.split(' ').first,
                        style: const TextStyle(fontSize: 9),
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: [
              for (var i = 0; i < cats.length; i++)
                BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: cats[i].$2,
                      width: 16,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(6),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          cats[i].$3,
                          cats[i].$3.withValues(alpha: 0.55),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HourlyHeatmap extends StatelessWidget {
  const _HourlyHeatmap();

  Color _heat(int value) {
    final t = (value / 50).clamp(0.0, 1.0);
    return Color.lerp(
      const Color(0xFFECFDF5),
      AppTheme.primary,
      t,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    final hours = AdminAnalyticsData.hourlyOrders;

    return _Panel(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 24,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final value = hours[index];
              return Tooltip(
                message: '$index:00 → $value orders',
                child: Container(
                  decoration: BoxDecoration(
                    color: _heat(value),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: value > 25
                          ? Colors.white
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Low',
                style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFECFDF5), AppTheme.primary],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Peak',
                style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FunnelCard extends StatelessWidget {
  const _FunnelCard();

  @override
  Widget build(BuildContext context) {
    final steps = AdminAnalyticsData.funnel;

    return _Panel(
      child: Column(
        children: [
          for (var i = 0; i < steps.length; i++) ...[
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth * (0.55 + steps[i].$3 * 0.45);
                return Column(
                  children: [
                    Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primary.withValues(alpha: 0.85 - i * 0.12),
                            AppTheme.secondary.withValues(alpha: 0.75 - i * 0.08),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              steps[i].$1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            '${steps[i].$2}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${(steps[i].$3 * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i < steps.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _RadarHealthCard extends StatelessWidget {
  const _RadarHealthCard();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ops health',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: RadarChart(
              RadarChartData(
                dataSets: [
                  RadarDataSet(
                    dataEntries: const [
                      RadarEntry(value: 94),
                      RadarEntry(value: 88),
                      RadarEntry(value: 81),
                      RadarEntry(value: 72),
                      RadarEntry(value: 86),
                    ],
                    fillColor: AppTheme.primary.withValues(alpha: 0.2),
                    borderColor: AppTheme.primary,
                    entryRadius: 2.5,
                    borderWidth: 2,
                  ),
                ],
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: false),
                radarBorderData: const BorderSide(color: AppTheme.borderLight),
                tickBorderData: const BorderSide(color: AppTheme.borderLight),
                gridBorderData: const BorderSide(color: AppTheme.borderLight),
                ticksTextStyle: const TextStyle(fontSize: 0),
                tickCount: 4,
                titleTextStyle: const TextStyle(fontSize: 9),
                getTitle: (index, angle) {
                  const titles = ['SLA', 'Fill', 'Stock', 'NPS', 'CSAT'];
                  return RadarChartTitle(text: titles[index], angle: angle);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CohortMiniCard extends StatelessWidget {
  const _CohortMiniCard();

  Color _cell(int value) {
    return Color.lerp(
      const Color(0xFFEFF6FF),
      AppTheme.secondary,
      value / 100,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    final rows = AdminAnalyticsData.cohortRetention;

    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Retention cohort',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          for (var r = 0; r < rows.length; r++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      'W$r',
                      style: const TextStyle(fontSize: 9),
                    ),
                  ),
                  for (final v in rows[r])
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _cell(v),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$v',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: v > 55 ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 6),
          const Text(
            'Week 0 → Week 6 retention %',
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _TopSkuCard extends StatelessWidget {
  const _TopSkuCard();

  @override
  Widget build(BuildContext context) {
    final skus = AdminAnalyticsData.topSkus;

    return _Panel(
      child: Column(
        children: [
          for (var i = 0; i < skus.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppTheme.primary.withValues(alpha: 0.12),
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skus[i].$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: skus[i].$3,
                            minHeight: 6,
                            backgroundColor: AppTheme.borderLight,
                            color: i == 0
                                ? AppTheme.accent
                                : AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${skus[i].$2}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _InsightStrip extends StatelessWidget {
  const _InsightStrip();

  @override
  Widget build(BuildContext context) {
    final insights = [
      (
        Icons.trending_up,
        'Peak demand 18:00–20:00',
        'Staff dark stores +18% for dinner rush',
        AppTheme.secondary,
      ),
      (
        Icons.inventory_2_outlined,
        'Atta & Oil driving 28% GMV',
        'Protect safety stock on top 5 SKUs',
        AppTheme.accent,
      ),
      (
        Icons.speed,
        'Checkout conversion 40%',
        'Cart→paid is healthy vs QC benchmarks',
        AppTheme.primary,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Analyst recommendations',
          subtitle: 'Actionable signals from this week’s model',
        ),
        const SizedBox(height: 10),
        for (final item in insights)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _Panel(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: item.$4.withValues(alpha: 0.12),
                    child: Icon(item.$1, color: item.$4, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          item.$3,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
