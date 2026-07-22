class QuickCommerceData {
  // Metric Counters & Data Analytics
  static const String todayRevenue = "₹32,45,678";
  static const String todayOrders = "12,458";
  static const String activeRiders = "1,245";
  static const String onlineStores = "245";
  static const String avgOrderValue = "₹260.5";
  static const String avgDeliveryTime = "8.4 min";
  static const String slaAdherence = "94.8%";
  static const String repeatCustomerRate = "78.4%";
  static const String pendingDeliveries = "1,256";
  static const String completedOrders = "8,245";
  static const String cancelledOrders = "812";
  static const String newCustomers = "8,932";
  static const String pendingPayments = "₹4,56,789";

  // Hourly Order & Revenue Analytics (24 Hours)
  static final List<HourlyAnalyticsModel> hourlyAnalytics = [
    HourlyAnalyticsModel(hour: "00:00", orders: 120, revenue: 31200, riders: 150),
    HourlyAnalyticsModel(hour: "02:00", orders: 45, revenue: 11700, riders: 80),
    HourlyAnalyticsModel(hour: "04:00", orders: 30, revenue: 7800, riders: 60),
    HourlyAnalyticsModel(hour: "06:00", orders: 210, revenue: 54600, riders: 280),
    HourlyAnalyticsModel(hour: "08:00", orders: 850, revenue: 221000, riders: 850),
    HourlyAnalyticsModel(hour: "10:00", orders: 1420, revenue: 369200, riders: 1100),
    HourlyAnalyticsModel(hour: "12:00", orders: 1890, revenue: 491400, riders: 1245),
    HourlyAnalyticsModel(hour: "14:00", orders: 1350, revenue: 351000, riders: 1150),
    HourlyAnalyticsModel(hour: "16:00", orders: 1100, revenue: 286000, riders: 980),
    HourlyAnalyticsModel(hour: "18:00", orders: 1980, revenue: 514800, riders: 1240),
    HourlyAnalyticsModel(hour: "20:00", orders: 2240, revenue: 582400, riders: 1245),
    HourlyAnalyticsModel(hour: "22:00", orders: 1223, revenue: 317980, riders: 890),
  ];

  // SLA Delivery Time Distribution Analytics
  static final List<SlaDistributionModel> slaDistribution = [
    SlaDistributionModel(range: "< 8 mins (Express)", count: 4820, percentage: 38.7, color: 0xFF10B981),
    SlaDistributionModel(range: "8 - 12 mins (Target)", count: 4210, percentage: 33.8, color: 0xFF3B82F6),
    SlaDistributionModel(range: "12 - 15 mins (Standard)", count: 2140, percentage: 17.2, color: 0xFFF59E0B),
    SlaDistributionModel(range: "15 - 20 mins (Delayed)", count: 980, percentage: 7.8, color: 0xFFEF4444),
    SlaDistributionModel(range: "> 20 mins (Breached)", count: 308, percentage: 2.5, color: 0xFF991B1B),
  ];

  // Category Revenue Analytics
  static final List<CategoryAnalyticsModel> categoryAnalytics = [
    CategoryAnalyticsModel(name: "Dairy, Milk & Eggs", share: 28.5, revenue: "₹9,25,000", orders: "3,550", growth: "+24.2%"),
    CategoryAnalyticsModel(name: "Snacks & Munchies", share: 22.1, revenue: "₹7,17,000", orders: "2,750", growth: "+18.6%"),
    CategoryAnalyticsModel(name: "Fresh Fruits & Veggies", share: 18.4, revenue: "₹5,97,000", orders: "2,290", growth: "+15.3%"),
    CategoryAnalyticsModel(name: "Cold Drinks & Juices", share: 14.8, revenue: "₹4,80,000", orders: "1,840", growth: "+12.1%"),
    CategoryAnalyticsModel(name: "Instant Food & Bakery", share: 10.2, revenue: "₹3,31,000", orders: "1,270", growth: "+8.4%"),
    CategoryAnalyticsModel(name: "Personal & Home Care", share: 6.0, revenue: "₹1,95,000", orders: "758", growth: "+5.1%"),
  ];

  // Recent Orders Data with Analytics Metadata
  static final List<OrderModel> recentOrders = [
    OrderModel(
      id: "#ORD125487",
      customerName: "Riya Sharma",
      customerPhone: "+91 98301 23456",
      customerAddress: "AE Block, Sector 1, Salt Lake, Kolkata - 700064",
      storeName: "FreshMart Salt Lake",
      storeAddress: "DF Block, Salt Lake, Kolkata - 700064",
      amount: "₹1,245",
      status: "Out for Delivery",
      riderName: "Rohan Kumar",
      riderPhone: "+91 98312 99887",
      items: ["Amul Milk 1L x2", "Whole Wheat Bread 400g x1", "Robusta Bananas 1kg x1", "Fortune Sunflower Oil 1L x1"],
      time: "21 May, 10:30 AM",
      eta: "7.2 min",
      distance: "2.4 km",
      pickupOtp: "4829",
      deliveryOtp: "7103",
      fulfillmentSla: "EXPRESS",
      margin: "26.4%",
      paymentMode: "UPI / PhonePe",
    ),
    OrderModel(
      id: "#ORD125486",
      customerName: "Arjun Das",
      customerPhone: "+91 98302 34567",
      customerAddress: "Gariahat Crossing, Ballygunge, Kolkata - 700019",
      storeName: "DailyNeeds Gariahat",
      storeAddress: "Ballygunge Circular Rd, Kolkata - 700019",
      amount: "₹899",
      status: "Out for Delivery",
      riderName: "Saurav Das",
      riderPhone: "+91 98314 44556",
      items: ["Nescafe Classic 200g x1", "Amul Butter 500g x1", "Epigamia Greek Yogurt x3"],
      time: "21 May, 10:28 AM",
      eta: "9.5 min",
      distance: "3.8 km",
      pickupOtp: "1942",
      deliveryOtp: "8821",
      fulfillmentSla: "TARGET",
      margin: "22.8%",
      paymentMode: "Credit Card",
    ),
    OrderModel(
      id: "#ORD125485",
      customerName: "Neha Verma",
      customerPhone: "+91 98303 45678",
      customerAddress: "Jessore Road, Dum Dum, Kolkata - 700028",
      storeName: "QuickStop Dumdum",
      storeAddress: "Nagerbazar Crossing, Kolkata - 700028",
      amount: "₹645",
      status: "Pending",
      riderName: "Amit Shaw",
      riderPhone: "+91 98311 22334",
      items: ["Lays Chips 50g x4", "Coca-Cola Zero 750ml x2", "Doritos Nacho Cheese x2"],
      time: "21 May, 10:25 AM",
      eta: "11.0 min",
      distance: "4.1 km",
      pickupOtp: "5630",
      deliveryOtp: "3391",
      fulfillmentSla: "TARGET",
      margin: "24.1%",
      paymentMode: "Cash on Delivery",
    ),
    OrderModel(
      id: "#ORD125484",
      customerName: "Subhajit Roy",
      customerPhone: "+91 98304 56789",
      customerAddress: "Action Area 1, Rajarhat, Kolkata - 700156",
      storeName: "GreenBasket Rajarhat",
      storeAddress: "New Town Main Rd, Kolkata - 700156",
      amount: "₹1,099",
      status: "Completed",
      riderName: "Bikash Mondal",
      riderPhone: "+91 98315 77889",
      items: ["Fresh Tomatoes 1kg x1", "Potatoes 2kg x1", "Onions 1kg x1", "Paneer 200g x2"],
      time: "21 May, 10:22 AM",
      eta: "6.8 min",
      distance: "1.8 km",
      pickupOtp: "9021",
      deliveryOtp: "5412",
      fulfillmentSla: "EXPRESS",
      margin: "28.5%",
      paymentMode: "Paytm UPI",
    ),
    OrderModel(
      id: "#ORD125483",
      customerName: "Priyanka Sen",
      customerPhone: "+91 98305 67890",
      customerAddress: "Diamond Harbour Rd, Behala, Kolkata - 700034",
      storeName: "SuperShop Behala",
      storeAddress: "Behala Tram Depot, Kolkata - 700034",
      amount: "₹2,150",
      status: "Cancelled",
      riderName: "Unassigned",
      riderPhone: "--",
      items: ["Pampers Baby Diapers L x1", "Cerelac Stage 2 x2"],
      time: "21 May, 10:18 AM",
      eta: "Cancelled",
      distance: "5.2 km",
      pickupOtp: "0000",
      deliveryOtp: "0000",
      fulfillmentSla: "BREACHED",
      margin: "0.0%",
      paymentMode: "Failed",
    ),
  ];

  // Store Performance Analytics
  static final List<StoreModel> topStores = [
    StoreModel(name: "FreshMart Salt Lake", orders: "1,245", revenue: "₹4,25,678", rating: 4.9, activeRiders: 18, avgTime: "7.8 min", slaScore: "96.4%"),
    StoreModel(name: "DailyNeeds Gariahat", orders: "985", revenue: "₹3,12,450", rating: 4.8, activeRiders: 14, avgTime: "8.5 min", slaScore: "94.2%"),
    StoreModel(name: "QuickStop Dumdum", orders: "876", revenue: "₹2,85,320", rating: 4.7, activeRiders: 12, avgTime: "9.1 min", slaScore: "92.8%"),
    StoreModel(name: "GreenBasket Rajarhat", orders: "765", revenue: "₹2,45,670", rating: 4.9, activeRiders: 15, avgTime: "8.1 min", slaScore: "95.9%"),
    StoreModel(name: "SuperShop Behala", orders: "654", revenue: "₹2,15,430", rating: 4.6, activeRiders: 10, avgTime: "9.8 min", slaScore: "91.2%"),
  ];

  // Low Stock Items Analytics
  static final List<StockAlertModel> lowStockAlerts = [
    StockAlertModel(item: "Amul Taaza Toned Milk 1L", store: "FreshMart Salt Lake", remaining: 12, minRequired: 50, urgency: "CRITICAL", reorderEta: "45 min"),
    StockAlertModel(item: "Britannia 100% Whole Wheat Bread", store: "DailyNeeds Gariahat", remaining: 8, minRequired: 40, urgency: "HIGH", reorderEta: "1.2 hrs"),
    StockAlertModel(item: "Fortune Refined Sunflower Oil 1L", store: "SuperShop Behala", remaining: 5, minRequired: 30, urgency: "CRITICAL", reorderEta: "30 min"),
    StockAlertModel(item: "Fresh Organic Eggs 6 Pack", store: "QuickStop Dumdum", remaining: 18, minRequired: 60, urgency: "MEDIUM", reorderEta: "2.0 hrs"),
  ];

  // AI Predictive Analytics Insights
  static final List<AiInsightModel> aiInsights = [
    AiInsightModel(
      title: "Demand Surge & Route Optimization",
      description: "AI predicts a +42% spike in Sector V (12:00 PM - 2:00 PM). Reallocating 25 riders from Rajarhat hub to optimize fulfillment SLA.",
      type: "DEMAND",
      confidence: "94.8%",
    ),
    AiInsightModel(
      title: "Automated Stock Replenishment",
      description: "Amul Milk 1L stock dropped below safety threshold. Auto-purchase order #PO-9921 issued to supplier (500 units ETA 45 min).",
      type: "STOCK",
      confidence: "98.2%",
    ),
    AiInsightModel(
      title: "Fraud Anomaly & SLA Guardrail",
      description: "Zero high-risk fraud anomalies. Delivery SLA adherence is optimal at 94.8% (average dispatch speed 1.4 minutes).",
      type: "FRAUD",
      confidence: "99.8%",
    ),
  ];

  // Rider Profile & Earnings
  static final RiderEarningsModel currentRiderEarnings = RiderEarningsModel(
    name: "Rohan Kumar",
    rating: 4.8,
    todayEarnings: "₹1,245",
    completedOrders: 6,
    totalWeeklyEarnings: "₹9,450",
    monthlyEarnings: "₹38,200",
    acceptanceRate: "98.5%",
    deliveryCount: 142,
    incentivesEarned: "₹850",
    vehicleNumber: "WB 01 AB 1234",
    vehicleType: "EV Scooter (Ather 450X)",
  );

  // Rider Leaderboard
  static final List<RiderLeaderboardModel> riderLeaderboard = [
    RiderLeaderboardModel(rank: 1, name: "Rohan Kumar", orders: 142, rating: 4.9, earnings: "₹9,450"),
    RiderLeaderboardModel(rank: 2, name: "Saurav Das", orders: 138, rating: 4.8, earnings: "₹9,120"),
    RiderLeaderboardModel(rank: 3, name: "Amit Shaw", orders: 129, rating: 4.7, earnings: "₹8,650"),
    RiderLeaderboardModel(rank: 4, name: "Bikash Mondal", orders: 121, rating: 4.8, earnings: "₹8,200"),
  ];

  // Active Promotional Coupons
  static final List<CouponModel> activeCoupons = [
    CouponModel(code: "FLASH100", usage: "4,820 Uses", description: "Flat ₹100 Off > ₹499", colorValue: 0xFF10B981),
    CouponModel(code: "SUPERMILK", usage: "2,140 Uses", description: "Free Delivery on Dairy", colorValue: 0xFF3B82F6),
    CouponModel(code: "FRESH20", usage: "1,290 Uses", description: "20% Off Fresh Vegetables", colorValue: 0xFFF59E0B),
  ];
}

class HourlyAnalyticsModel {
  final String hour;
  final int orders;
  final double revenue;
  final int riders;

  HourlyAnalyticsModel({required this.hour, required this.orders, required this.revenue, required this.riders});
}

class SlaDistributionModel {
  final String range;
  final int count;
  final double percentage;
  final int color;

  SlaDistributionModel({required this.range, required this.count, required this.percentage, required this.color});
}

class CategoryAnalyticsModel {
  final String name;
  final double share;
  final String revenue;
  final String orders;
  final String growth;

  CategoryAnalyticsModel({required this.name, required this.share, required this.revenue, required this.orders, required this.growth});
}

class OrderModel {
  final String id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String storeName;
  final String storeAddress;
  final String amount;
  final String status;
  final String riderName;
  final String riderPhone;
  final List<String> items;
  final String time;
  final String eta;
  final String distance;
  final String pickupOtp;
  final String deliveryOtp;
  final String? _fulfillmentSla;
  final String? _margin;
  final String? _paymentMode;

  String get fulfillmentSla => _fulfillmentSla ?? "TARGET";
  String get margin => _margin ?? "24.0%";
  String get paymentMode => _paymentMode ?? "Online UPI";

  OrderModel({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.storeName,
    required this.storeAddress,
    required this.amount,
    required this.status,
    required this.riderName,
    required this.riderPhone,
    required this.items,
    required this.time,
    required this.eta,
    required this.distance,
    required this.pickupOtp,
    required this.deliveryOtp,
    String? fulfillmentSla = "TARGET",
    String? margin = "24.0%",
    String? paymentMode = "Online UPI",
  })  : _fulfillmentSla = fulfillmentSla,
        _margin = margin,
        _paymentMode = paymentMode;
}

class StoreModel {
  final String name;
  final String orders;
  final String revenue;
  final double rating;
  final int activeRiders;
  final String avgTime;
  final String slaScore;

  StoreModel({
    required this.name,
    required this.orders,
    required this.revenue,
    required this.rating,
    required this.activeRiders,
    required this.avgTime,
    required this.slaScore,
  });
}

class StockAlertModel {
  final String item;
  final String store;
  final int remaining;
  final int minRequired;
  final String urgency;
  final String reorderEta;

  StockAlertModel({
    required this.item,
    required this.store,
    required this.remaining,
    required this.minRequired,
    required this.urgency,
    required this.reorderEta,
  });
}

class AiInsightModel {
  final String title;
  final String description;
  final String type;
  final String confidence;

  AiInsightModel({
    required this.title,
    required this.description,
    required this.type,
    required this.confidence,
  });
}

class RiderEarningsModel {
  final String name;
  final double rating;
  final String todayEarnings;
  final int completedOrders;
  final String totalWeeklyEarnings;
  final String monthlyEarnings;
  final String acceptanceRate;
  final int deliveryCount;
  final String incentivesEarned;
  final String vehicleNumber;
  final String vehicleType;

  RiderEarningsModel({
    required this.name,
    required this.rating,
    required this.todayEarnings,
    required this.completedOrders,
    required this.totalWeeklyEarnings,
    required this.monthlyEarnings,
    required this.acceptanceRate,
    required this.deliveryCount,
    required this.incentivesEarned,
    required this.vehicleNumber,
    required this.vehicleType,
  });
}

class RiderLeaderboardModel {
  final int rank;
  final String name;
  final int orders;
  final double rating;
  final String earnings;

  RiderLeaderboardModel({
    required this.rank,
    required this.name,
    required this.orders,
    required this.rating,
    required this.earnings,
  });
}

class CouponModel {
  final String code;
  final String usage;
  final String description;
  final int colorValue;

  CouponModel({
    required this.code,
    required this.usage,
    required this.description,
    required this.colorValue,
  });
}
