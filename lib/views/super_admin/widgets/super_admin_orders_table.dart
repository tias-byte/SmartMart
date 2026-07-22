import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../theme/app_theme.dart';
import '../../../models/quick_commerce_models.dart';

class SuperAdminOrdersTable extends StatefulWidget {
  final bool isDark;
  final Function(OrderModel) onSelectOrder;

  const SuperAdminOrdersTable({
    super.key,
    required this.isDark,
    required this.onSelectOrder,
  });

  @override
  State<SuperAdminOrdersTable> createState() => _SuperAdminOrdersTableState();
}

class _SuperAdminOrdersTableState extends State<SuperAdminOrdersTable> {
  String? _selectedFilter;
  String get selectedFilter => _selectedFilter ?? "All";

  @override
  void initState() {
    super.initState();
    _selectedFilter = "All";
  }

  @override
  Widget build(BuildContext context) {
    List<OrderModel> filteredOrders = QuickCommerceData.recentOrders;
    if (selectedFilter != "All") {
      filteredOrders = QuickCommerceData.recentOrders.where((o) {
        final String s = o.status;
        final String sla = o.fulfillmentSla;
        return s == selectedFilter || sla == selectedFilter;
      }).toList();
    }

    return Container(
      decoration: AppTheme.glassCard(isDark: widget.isDark),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Data Analytics Bar
          Flex(
            direction: MediaQuery.of(context).size.width <= 900 ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: MediaQuery.of(context).size.width <= 900 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(
                        "Real-Time Order & SLA Dispatch Log",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "LIVE TELEMETRY",
                          style: GoogleFonts.inter(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Multi-store order stream with SLA compliance, gross margin %, and payment telemetry",
                    style: GoogleFonts.inter(fontSize: 11.5, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                  ),
                ],
              ),
              if (MediaQuery.of(context).size.width <= 900) const SizedBox(height: 16),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Export CSV Action
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: widget.isDark ? AppTheme.borderDarkActive : const Color(0xFFE2E8F0)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Exporting Order Telemetry CSV..."), backgroundColor: AppTheme.primary),
                      );
                    },
                    icon: const Icon(LucideIcons.download, size: 14, color: AppTheme.primary),
                    label: Text("Export CSV", style: GoogleFonts.inter(fontSize: 11.5, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                  ),

                  // Status Filters
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: ["All", "Out for Delivery", "Pending", "Completed", "Cancelled"].map((status) {
                      final bool isActive = selectedFilter == status;
                      return InkWell(
                        onTap: () => setState(() => _selectedFilter = status),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppTheme.primary
                                : (widget.isDark ? AppTheme.cardDarkElevated : const Color(0xFFF1F5F9)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                              color: isActive ? Colors.white : (widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Orders Data Table with Analytics Dimensions
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  widget.isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                ),
                dataRowMinHeight: 52,
                dataRowMaxHeight: 58,
                horizontalMargin: 16,
                columnSpacing: 24,
                columns: [
                  DataColumn(label: Text("ORDER ID", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("TIMESTAMP", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("CUSTOMER", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("DARK STORE", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("FULFILLMENT SLA", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("ETA", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("MARGIN %", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("PAYMENT", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("AMOUNT", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("STATUS", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("ACTION", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold))),
                ],
                rows: filteredOrders.map((order) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          order.id,
                          style: GoogleFonts.inter(fontSize: 12.5, fontWeight: FontWeight.bold, color: AppTheme.secondary),
                        ),
                      ),
                      DataCell(
                        Text(
                          order.time,
                          style: GoogleFonts.inter(fontSize: 11.5, color: widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                        ),
                      ),
                      DataCell(
                        Text(
                          order.customerName,
                          style: GoogleFonts.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: widget.isDark ? Colors.white : Colors.black87),
                        ),
                      ),
                      DataCell(
                        Text(
                          order.storeName,
                          style: GoogleFonts.inter(fontSize: 12, color: widget.isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155)),
                        ),
                      ),
                      DataCell(_buildSlaBadge(order.fulfillmentSla)),
                      DataCell(
                        Row(
                          children: [
                            const Icon(LucideIcons.clock, size: 12, color: AppTheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              order.eta,
                              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Text(
                          order.margin,
                          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primary),
                        ),
                      ),
                      DataCell(
                        Text(
                          order.paymentMode,
                          style: GoogleFonts.inter(fontSize: 11.5, color: widget.isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569)),
                        ),
                      ),
                      DataCell(
                        Text(
                          order.amount,
                          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primary),
                        ),
                      ),
                      DataCell(_buildStatusBadge(order.status)),
                      DataCell(
                        IconButton(
                          icon: const Icon(LucideIcons.barChart2, size: 16, color: AppTheme.secondary),
                          onPressed: () => widget.onSelectOrder(order),
                          tooltip: "Inspect Telemetry",
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlaBadge(String? slaInput) {
    final String sla = slaInput ?? "TARGET";
    Color bg;
    Color fg;

    switch (sla) {
      case "EXPRESS":
        bg = AppTheme.primary.withOpacity(0.15);
        fg = AppTheme.primary;
        break;
      case "TARGET":
        bg = AppTheme.secondary.withOpacity(0.15);
        fg = AppTheme.secondary;
        break;
      case "BREACHED":
      default:
        bg = AppTheme.danger.withOpacity(0.15);
        fg = AppTheme.danger;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        sla,
        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: fg),
      ),
    );
  }

  Widget _buildStatusBadge(String? statusInput) {
    final String status = statusInput ?? "Pending";
    Color bg;
    Color fg;

    switch (status) {
      case "Out for Delivery":
        bg = AppTheme.secondary.withOpacity(0.15);
        fg = AppTheme.secondary;
        break;
      case "Completed":
      case "Delivered":
        bg = AppTheme.primary.withOpacity(0.15);
        fg = AppTheme.primary;
        break;
      case "Pending":
        bg = AppTheme.accent.withOpacity(0.15);
        fg = AppTheme.accent;
        break;
      case "Cancelled":
      default:
        bg = AppTheme.danger.withOpacity(0.15);
        fg = AppTheme.danger;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        status,
        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}

