import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Demo analytics dataset for the admin command center.
class AdminAnalyticsData {
  static const revenueByDay = [8.2, 9.1, 7.8, 10.4, 11.2, 12.6, 14.1];
  static const ordersByDay = [32, 41, 28, 45, 52, 48, 61];
  static const aovByDay = [256, 222, 279, 231, 215, 262, 231];

  static const weekLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  static const categorySales = [
    ('Grocery', 38.0, Color(0xFF10B981)),
    ('Beauty', 18.0, Color(0xFF3B82F6)),
    ('Electronics', 16.0, Color(0xFFF59E0B)),
    ('Fashion', 14.0, Color(0xFF8B5CF6)),
    ('Kids', 8.0, Color(0xFFEF4444)),
    ('Other', 6.0, Color(0xFF64748B)),
  ];

  static const orderStatus = [
    ('Delivered', 52.0, Color(0xFF10B981)),
    ('Out for delivery', 22.0, Color(0xFF3B82F6)),
    ('Pending', 18.0, Color(0xFFF59E0B)),
    ('Cancelled', 8.0, Color(0xFFEF4444)),
  ];

  static const hourlyOrders = [
    4, 2, 1, 1, 3, 8, 14, 22, 28, 31, 26, 24,
    29, 33, 30, 27, 35, 42, 48, 39, 28, 18, 12, 7,
  ];

  static const funnel = [
    ('App opens', 12400, 1.0),
    ('Product views', 8200, 0.66),
    ('Add to cart', 3100, 0.25),
    ('Checkout', 1680, 0.135),
    ('Paid orders', 1240, 0.1),
  ];

  static const topSkus = [
    ('Chakki Atta 5kg', 842, 0.92),
    ('Sunflower Oil 1L', 711, 0.78),
    ('Potato Chips', 654, 0.71),
    ('Cream Biscuits', 598, 0.65),
    ('Tomato Ketchup', 512, 0.56),
  ];

  static const cohortRetention = [
    [100, 62, 48, 41, 36, 33, 30],
    [100, 58, 44, 38, 34, 30, 28],
    [100, 65, 51, 43, 39, 35, 32],
    [100, 60, 46, 40, 35, 31, 29],
  ];

  static const deliverySla = 0.94;
  static const stockHealth = 0.81;
  static const npsScore = 0.72;
  static const fillRate = 0.88;

  static double get totalRevenue =>
      revenueByDay.fold(0.0, (a, b) => a + b);

  static int get totalOrders =>
      ordersByDay.fold(0, (a, b) => a + b);

  static double get avgOrderValue =>
      (totalRevenue * 1000) / totalOrders;

  static double get wowGrowth {
    final prev = revenueByDay.take(3).fold(0.0, (a, b) => a + b) / 3;
    final curr = revenueByDay.skip(4).fold(0.0, (a, b) => a + b) / 3;
    return ((curr - prev) / prev) * 100;
  }

  static double stdDev(List<num> values) {
    final mean = values.fold<double>(0, (a, b) => a + b) / values.length;
    final variance = values.fold<double>(
          0,
          (a, b) => a + math.pow(b - mean, 2),
        ) /
        values.length;
    return math.sqrt(variance);
  }
}
