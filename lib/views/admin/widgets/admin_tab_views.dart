import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';
import 'admin_orders_table.dart';

class AdminTabViews {
  static Widget buildTabView({
    required BuildContext context,
    required String activeTab,
    required bool isDark,
    required Function(OrderModel) onSelectOrder,
    required VoidCallback onRefresh,
  }) {
    switch (activeTab) {
      case "Orders":
        return _buildOrdersView(isDark, onSelectOrder);
      case "Stores":
        return _buildStoresView(context, isDark, onRefresh);
      case "Products":
        return _buildProductsView(isDark);
      case "Inventory":
        return _buildInventoryView(isDark);
      case "Categories":
        return _buildCategoriesView(isDark);
      case "Customers":
        return _buildCustomersView(isDark);
      case "Riders":
        return _buildRidersView(context, isDark, onRefresh);
      case "Payments":
        return _buildPaymentsView(isDark);
      case "Coupons":
        return _buildCouponsView(context, isDark, onRefresh);
      case "Reports":
        return _buildReportsView(isDark);
      case "Settings":
        return _buildSettingsView(isDark);
      case "Dashboard":
      default:
        return const SizedBox.shrink();
    }
  }

  // 1. ORDERS TAB VIEW
  static Widget _buildOrdersView(bool isDark, Function(OrderModel) onSelectOrder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Store Order Telemetry & SLA Center",
          subtitle: "Live local dispatch log for Dark Store #14 with real-time SLA breach tracking",
          tag: "248 TODAY",
          icon: LucideIcons.shoppingBag,
        ),
        const SizedBox(height: 20),
        AdminOrdersTable(isDark: isDark, onSelectOrder: onSelectOrder),
      ],
    );
  }

  // 2. STORES TAB VIEW
  static Widget _buildStoresView(BuildContext context, bool isDark, VoidCallback onRefresh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Dark Store Hubs Network Analytics",
          subtitle: "Real-time performance, active riders, SLA scores & stock health across all 245 hubs",
          tag: "${QuickCommerceData.topStores.length} HUBS ONLINE",
          icon: LucideIcons.store,
          trailing: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => _showAddStoreDialog(context, isDark, onRefresh),
            icon: const Icon(LucideIcons.plus, size: 16),
            label: Text("Register Store", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = constraints.maxWidth > 1100
                ? (constraints.maxWidth - 32) / 3
                : (constraints.maxWidth > 700
                    ? (constraints.maxWidth - 16) / 2
                    : constraints.maxWidth);

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: QuickCommerceData.topStores.map((store) {
                return SizedBox(
                  width: cardWidth,
                  height: 160,
                  child: Container(
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
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(LucideIcons.store, color: AppTheme.primary, size: 18),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(store.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis),
                                        Text("Rating ${store.rating} ★ • Active Hub", style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                              child: Text("ONLINE", style: GoogleFonts.inter(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _storeMetric("Orders", store.orders, isDark),
                            _storeMetric("Revenue", store.revenue, isDark),
                            _storeMetric("SLA Score", store.slaScore, isDark, isHighlight: true),
                            _storeMetric("Riders", "${store.activeRiders}", isDark),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  // 3. PRODUCTS TAB VIEW
  static Widget _buildProductsView(bool isDark) {
    final products = [
      {'name': 'Amul Taaza Milk 1L', 'category': 'Dairy & Eggs', 'price': '₹72', 'stock': '12 units (CRITICAL)', 'margin': '24.5%', 'sales': '3,550'},
      {'name': 'Britannia 100% Wheat Bread', 'category': 'Bakery', 'price': '₹45', 'stock': '8 units (LOW)', 'margin': '22.0%', 'sales': '2,750'},
      {'name': 'Fortune Sunflower Oil 1L', 'category': 'Edible Oil', 'price': '₹145', 'stock': '5 units (CRITICAL)', 'margin': '28.4%', 'sales': '1,840'},
      {'name': 'Epigamia Greek Yogurt 90g', 'category': 'Dairy & Eggs', 'price': '₹60', 'stock': '45 units (GOOD)', 'margin': '31.2%', 'sales': '1,270'},
      {'name': 'Coca-Cola Zero 750ml', 'category': 'Cold Drinks', 'price': '₹40', 'stock': '88 units (OPTIMAL)', 'margin': '35.0%', 'sales': '2,290'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Product SKUs & Local Inventory",
          subtitle: "Catalog stock levels and inventory velocity for Dark Store #14",
          tag: "1,850 SKUs",
          icon: LucideIcons.package,
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(height: 16, color: Color(0xFF1E293B)),
            itemBuilder: (context, index) {
              final p = products[index];
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppTheme.secondary.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(LucideIcons.package, color: AppTheme.secondary, size: 18),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p['name']!, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13.5, color: isDark ? Colors.white : Colors.black87)),
                        Text("Category: ${p['category']} • Margin: ${p['margin']}", style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(p['price']!, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.primary)),
                      Text("Sales: ${p['sales']} units", style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: p['stock']!.contains('CRITICAL') ? AppTheme.danger.withOpacity(0.15) : AppTheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      p['stock']!,
                      style: GoogleFonts.inter(fontSize: 10.5, fontWeight: FontWeight.bold, color: p['stock']!.contains('CRITICAL') ? AppTheme.danger : AppTheme.primary),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // 4. INVENTORY TAB VIEW
  static Widget _buildInventoryView(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Automated Stock Replenishment & Safety Thresholds",
          subtitle: "AI predictive inventory alerts, supplier purchase order logs & stockout risk prevention",
          tag: "96.5% HEALTH",
          icon: LucideIcons.boxes,
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Critical Low Stock Alerts & Automated PO Issuance", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 14),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: QuickCommerceData.lowStockAlerts.length,
                separatorBuilder: (context, index) => const Divider(height: 16, color: Color(0xFF1E293B)),
                itemBuilder: (context, index) {
                  final alert = QuickCommerceData.lowStockAlerts[index];
                  return Row(
                    children: [
                      const Icon(LucideIcons.alertTriangle, color: AppTheme.accent, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(alert.item, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87)),
                            Text("Store: ${alert.store} • Min Threshold: ${alert.minRequired} units", style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${alert.remaining} Left", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppTheme.danger, fontSize: 13)),
                          Text("Reorder ETA: ${alert.reorderEta}", style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                        ],
                      ),
                      const SizedBox(width: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                        onPressed: () {},
                        child: Text("Auto-Reorder PO", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 5. CATEGORIES TAB VIEW
  static Widget _buildCategoriesView(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Sector Category Revenue & Gross Margin Matrix",
          subtitle: "Sector-wise sales distribution, volume contribution & year-over-year revenue growth",
          tag: "6 SECTORS",
          icon: LucideIcons.grid,
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = constraints.maxWidth > 1100
                ? (constraints.maxWidth - 32) / 3
                : (constraints.maxWidth > 700
                    ? (constraints.maxWidth - 16) / 2
                    : constraints.maxWidth);

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: QuickCommerceData.categoryAnalytics.map((cat) {
                return SizedBox(
                  width: cardWidth,
                  height: 140,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppTheme.glassCard(isDark: isDark),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                cat.name,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                              child: Text(cat.growth, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _storeMetric("Market Share", "${cat.share}%", isDark),
                            _storeMetric("Gross Rev", cat.revenue, isDark, isHighlight: true),
                            _storeMetric("Orders Volume", cat.orders, isDark),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  // 6. CUSTOMERS TAB VIEW
  static Widget _buildCustomersView(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Customer Cohorts & Retention Intelligence",
          subtitle: "78.4% repeat purchase rate, lifetime value (LTV) telemetry & churn risk scoring",
          tag: "78.4% REPEAT",
          icon: LucideIcons.users,
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer Retention Metrics", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: 240,
                    child: _metricTile("Active Customers", "8,932", "+12.4% vs last week", AppTheme.primary, isDark),
                  ),
                  SizedBox(
                    width: 240,
                    child: _metricTile("Repeat Customer Rate", "78.4%", "Target: > 75.0%", AppTheme.secondary, isDark),
                  ),
                  SizedBox(
                    width: 240,
                    child: _metricTile("Avg Customer LTV", "₹4,850", "3.2 orders/month", AppTheme.accent, isDark),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 7. RIDERS TAB VIEW
  static Widget _buildRidersView(BuildContext context, bool isDark, VoidCallback onRefresh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Local Fleet Dispatch & Rider Roster",
          subtitle: "8 active riders online • 2 on break • 100% SLA compliance rate for Dark Store #14",
          tag: "10 RIDERS",
          icon: LucideIcons.bike,
          trailing: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => _showAddRiderDialog(context, isDark, onRefresh),
            icon: const Icon(LucideIcons.plus, size: 16),
            label: Text("Onboard Rider", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Top Delivery Rider Leaderboard", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 14),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: QuickCommerceData.riderLeaderboard.length,
                separatorBuilder: (context, index) => const Divider(height: 14, color: Color(0xFF1E293B)),
                itemBuilder: (context, index) {
                  final r = QuickCommerceData.riderLeaderboard[index];
                  return Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), shape: BoxShape.circle),
                        child: Center(child: Text("#${r.rank}", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 12))),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.name, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87)),
                            Text("Rating ${r.rating} ★ • EV Scooter Rider", style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Text("${r.orders} Deliveries", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12.5)),
                      const SizedBox(width: 20),
                      Text(r.earnings, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 13)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 8. PAYMENTS TAB VIEW
  static Widget _buildPaymentsView(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Financial Audit & Payment Gateway Telemetry",
          subtitle: "99.4% transaction success rate • UPI, Credit Card & COD settlement tracking",
          tag: "99.4% SUCCESS",
          icon: LucideIcons.creditCard,
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Settled Revenue & Settlement Payouts", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: 240,
                    child: _metricTile("Today Settled Revenue", "₹32,45,678", "Instant Bank Payout", AppTheme.primary, isDark),
                  ),
                  SizedBox(
                    width: 240,
                    child: _metricTile("Pending Payouts", "₹4,56,789", "Settlement T+1", AppTheme.accent, isDark),
                  ),
                  SizedBox(
                    width: 240,
                    child: _metricTile("UPI / PhonePe Share", "64.2%", "Primary Gateway", AppTheme.secondary, isDark),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 9. COUPONS TAB VIEW
  static Widget _buildCouponsView(BuildContext context, bool isDark, VoidCallback onRefresh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Promotional Campaigns & Discount ROI",
          subtitle: "Active coupon codes, redemption volume & net margin impact analytics",
          tag: "${QuickCommerceData.activeCoupons.length} ACTIVE",
          icon: LucideIcons.ticket,
          trailing: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => _showAddCouponDialog(context, isDark, onRefresh),
            icon: const Icon(LucideIcons.plus, size: 16),
            label: Text("Create Coupon", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Active Promos & Discount Conversion", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: QuickCommerceData.activeCoupons.map((coupon) {
                  return SizedBox(
                    width: 240,
                    child: _metricTile(
                      coupon.code,
                      coupon.usage,
                      coupon.description,
                      Color(coupon.colorValue),
                      isDark,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }



  // 11. REPORTS TAB VIEW
  static Widget _buildReportsView(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "Automated Data Export & Compliance Reports",
          subtitle: "Scheduled daily, weekly, and monthly audit reports with instant CSV/PDF export",
          tag: "AUTO EXPORT",
          icon: LucideIcons.fileText,
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _reportRow("Daily Financial Audit Log", "PDF & CSV • Generated 10:00 AM", isDark),
              const Divider(height: 16),
              _reportRow("Dark Store SLA Compliance Telemetry", "CSV • Realtime Stream", isDark),
              const Divider(height: 16),
              _reportRow("Rider Payout & Incentives Ledger", "PDF • Weekly Audit", isDark),
            ],
          ),
        ),
      ],
    );
  }



  // 13. SETTINGS TAB VIEW
  static Widget _buildSettingsView(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabHeader(
          isDark,
          title: "System Operational Guardrails & SLA Settings",
          subtitle: "Configure Express SLA targets, Dark Store dispatch radius & AI anomaly sensitivity",
          tag: "SYSTEM GUARDRAILS",
          icon: LucideIcons.settings,
        ),
        const SizedBox(height: 20),
        Container(
          decoration: AppTheme.glassCard(isDark: isDark),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _settingRow("Express Delivery Target SLA", "8.0 minutes (Default)", isDark),
              const Divider(height: 16),
              _settingRow("Dark Store Dispatch Radius", "3.5 kilometers max", isDark),
              const Divider(height: 16),
              _settingRow("AI Fraud & Anomaly Sensitivity", "99.5% High Confidence Threshold", isDark),
            ],
          ),
        ),
      ],
    );
  }

  // Helper UI Builders
  static Widget _buildTabHeader(
    bool isDark, {
    required String title,
    required String subtitle,
    required String tag,
    required IconData icon,
    Widget? trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppTheme.primary, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                    child: Text(tag, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(fontSize: 12.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 16),
          trailing,
        ],
      ],
    );
  }

  static Widget _storeMetric(String title, String val, bool isDark, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(fontSize: 10, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
        Text(val, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: isHighlight ? AppTheme.primary : (isDark ? Colors.white : Colors.black87))),
      ],
    );
  }

  static Widget _metricTile(String title, String mainVal, String subVal, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 11.5, color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569))),
          const SizedBox(height: 4),
          Text(mainVal, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(subVal, style: GoogleFonts.inter(fontSize: 10.5, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
        ],
      ),
    );
  }

  static Widget _reportRow(String name, String desc, bool isDark) {
    return Row(
      children: [
        const Icon(LucideIcons.fileText, color: AppTheme.primary, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                desc,
                style: GoogleFonts.inter(fontSize: 11, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
          onPressed: () {},
          icon: const Icon(LucideIcons.download, size: 14, color: Colors.white),
          label: Text("Export Data", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
    );
  }



  static Widget _settingRow(String name, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : const Color(0xFF0F172A)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
          child: Text(value, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primary)),
        ),
      ],
    );
  }

  static void _showAddStoreDialog(BuildContext context, bool isDark, VoidCallback onRefresh) {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final ridersController = TextEditingController(text: "12");
    final slaController = TextEditingController(text: "95.5%");
    final timeController = TextEditingController(text: "8.2 min");
    final revenueController = TextEditingController(text: "₹1,50,000");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppTheme.cardDarkElevated : Colors.white,
          title: Text("Register New Dark Store", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(labelText: "Store Name", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54), hintText: "e.g. Salt Lake Hub 2"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(labelText: "Address", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54), hintText: "e.g. Sector V, Salt Lake"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ridersController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        decoration: InputDecoration(labelText: "Active Riders", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: slaController,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        decoration: InputDecoration(labelText: "SLA Score", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: timeController,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        decoration: InputDecoration(labelText: "Avg Delivery Time", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: revenueController,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        decoration: InputDecoration(labelText: "Est. Revenue", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.inter(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
              onPressed: () {
                if (nameController.text.isNotEmpty && addressController.text.isNotEmpty) {
                  final newStore = StoreModel(
                    name: nameController.text,
                    orders: "0",
                    revenue: revenueController.text,
                    rating: 4.8,
                    activeRiders: int.tryParse(ridersController.text) ?? 10,
                    avgTime: timeController.text,
                    slaScore: slaController.text,
                  );
                  QuickCommerceData.topStores.add(newStore);
                  Navigator.pop(context);
                  onRefresh();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Registered ${nameController.text} successfully!"), backgroundColor: AppTheme.primary),
                  );
                }
              },
              child: Text("Register", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  static void _showAddRiderDialog(BuildContext context, bool isDark, VoidCallback onRefresh) {
    final nameController = TextEditingController();
    final earningsController = TextEditingController(text: "₹0");
    final deliveriesController = TextEditingController(text: "0");
    final ratingController = TextEditingController(text: "4.8");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppTheme.cardDarkElevated : Colors.white,
          title: Text("Onboard New Rider Partner", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(labelText: "Rider Name", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54), hintText: "e.g. Vikram Singh"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: deliveriesController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(labelText: "Deliveries Today", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: earningsController,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                      decoration: InputDecoration(labelText: "Earnings Today", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: ratingController,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                      decoration: InputDecoration(labelText: "Initial Rating (★)", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.inter(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  final newRider = RiderLeaderboardModel(
                    rank: QuickCommerceData.riderLeaderboard.length + 1,
                    name: nameController.text,
                    orders: int.tryParse(deliveriesController.text) ?? 0,
                    rating: double.tryParse(ratingController.text) ?? 4.8,
                    earnings: earningsController.text,
                  );
                  QuickCommerceData.riderLeaderboard.add(newRider);
                  Navigator.pop(context);
                  onRefresh();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Onboarded ${nameController.text} successfully!"), backgroundColor: AppTheme.primary),
                  );
                }
              },
              child: Text("Onboard", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  static void _showAddCouponDialog(BuildContext context, bool isDark, VoidCallback onRefresh) {
    final codeController = TextEditingController();
    final descController = TextEditingController();
    final categoryNotifier = ValueNotifier<String>("Primary (Green)");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppTheme.cardDarkElevated : Colors.white,
          title: Text("Create Promotional Coupon", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(labelText: "Promo Code", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54), hintText: "e.g. MONSOON50"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(labelText: "Description", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54), hintText: "e.g. 50% Off up to ₹100"),
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder<String>(
                valueListenable: categoryNotifier,
                builder: (context, currentVal, _) {
                  return DropdownButtonFormField<String>(
                    value: currentVal,
                    dropdownColor: isDark ? AppTheme.cardDarkElevated : Colors.white,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    decoration: InputDecoration(labelText: "Color Theme / Category", labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                    items: ["Primary (Green)", "Secondary (Blue)", "Accent (Amber)"].map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat, style: TextStyle(color: isDark ? Colors.white : Colors.black87)));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) categoryNotifier.value = val;
                    },
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.inter(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
              onPressed: () {
                if (codeController.text.isNotEmpty && descController.text.isNotEmpty) {
                  int selectedColorValue = 0xFF10B981; // Green
                  if (categoryNotifier.value == "Secondary (Blue)") {
                    selectedColorValue = 0xFF3B82F6;
                  } else if (categoryNotifier.value == "Accent (Amber)") {
                    selectedColorValue = 0xFFF59E0B;
                  }

                  final newCoupon = CouponModel(
                    code: codeController.text.toUpperCase(),
                    usage: "0 Uses",
                    description: descController.text,
                    colorValue: selectedColorValue,
                  );
                  QuickCommerceData.activeCoupons.add(newCoupon);
                  Navigator.pop(context);
                  onRefresh();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Created coupon ${codeController.text} successfully!"), backgroundColor: AppTheme.primary),
                  );
                }
              },
              child: Text("Create", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
