import 'package:flutter/material.dart';
import 'package:smartcart/theme/app_colors.dart';

class ProductItem {
  final String name;
  final String price;
  final IconData icon;
  final Color color;

  const ProductItem({
    required this.name,
    required this.price,
    required this.icon,
    required this.color,
  });
}

class ShopCategory {
  final String title;
  final String topTab;
  final List<ProductItem> products;
  final Color tint;

  const ShopCategory({
    required this.title,
    required this.topTab,
    required this.products,
    required this.tint,
  });
}

class TopTab {
  final String label;
  final IconData icon;

  const TopTab({required this.label, required this.icon});
}

class BannerSlide {
  final String title;
  final String subtitle;
  final String brand;
  final Color background;
  final IconData icon;
  final Color iconColor;

  const BannerSlide({
    required this.title,
    required this.subtitle,
    required this.brand,
    required this.background,
    required this.icon,
    required this.iconColor,
  });
}

class StoreInfo {
  final String name;
  final String distance;
  final String time;
  final double rating;
  final String category;

  const StoreInfo({
    required this.name,
    required this.distance,
    required this.time,
    required this.rating,
    required this.category,
  });
}

class AppData {
  static const List<String> locations = [
    'Old Dhatia Falia',
    'Railway Station Road',
    'City Center',
    'Market Yard',
  ];

  static const Map<String, String> locationAddresses = {
    'Old Dhatia Falia':
        'Railway Station Road, Old Dhatia Falia, Bhandara',
    'Railway Station Road':
        'Near Platform 1, Railway Station Road, Bhandara',
    'City Center': 'Main Market, City Center, Bhandara',
    'Market Yard': 'Wholesale Market Yard, Bhandara',
  };

  static const List<TopTab> topTabs = [
    TopTab(label: 'All', icon: Icons.grid_view_rounded),
    TopTab(label: 'Beauty', icon: Icons.spa_outlined),
    TopTab(label: 'Electronics', icon: Icons.devices_other_outlined),
    TopTab(label: 'Fashion', icon: Icons.checkroom_outlined),
    TopTab(label: 'Grocery', icon: Icons.shopping_basket_outlined),
    TopTab(label: 'Kids', icon: Icons.child_care_outlined),
  ];

  static const List<BannerSlide> banners = [
    BannerSlide(
      title: 'Embrace the Freshness...',
      subtitle: 'Fresh Chakki Atta',
      brand: 'VIKRAM MILLS',
      background: Color(0xFFFFF7ED),
      icon: Icons.grain,
      iconColor: Color(0xFFD97706),
    ),
    BannerSlide(
      title: 'Daily essentials',
      subtitle: 'Up to 40% off',
      brand: 'SMARTMART DEALS',
      background: Color(0xFFEFF6FF),
      icon: Icons.local_offer_outlined,
      iconColor: Color(0xFF2563EB),
    ),
    BannerSlide(
      title: 'Fresh dairy',
      subtitle: 'Delivered in minutes',
      brand: 'FARM FRESH',
      background: Color(0xFFF0FDF4),
      icon: Icons.egg_outlined,
      iconColor: Color(0xFF16A34A),
    ),
    BannerSlide(
      title: 'Snack time',
      subtitle: 'Chips & biscuits specials',
      brand: 'CRUNCH ZONE',
      background: Color(0xFFFDF2F8),
      icon: Icons.cookie_outlined,
      iconColor: Color(0xFFDB2777),
    ),
  ];

  static final List<ShopCategory> categories = [
    ShopCategory(
      title: 'Biscuits & Cakes',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Cream Biscuits',
          price: '₹35',
          icon: Icons.cookie_outlined,
          color: Color(0xFFD97706),
        ),
        ProductItem(
          name: 'Chocolate Cake',
          price: '₹249',
          icon: Icons.cake_outlined,
          color: Color(0xFF92400E),
        ),
        ProductItem(
          name: 'Marie Gold',
          price: '₹30',
          icon: Icons.bakery_dining_outlined,
          color: Color(0xFFB45309),
        ),
        ProductItem(
          name: 'Cupcakes Pack',
          price: '₹99',
          icon: Icons.icecream_outlined,
          color: Color(0xFFEC4899),
        ),
      ],
    ),
    ShopCategory(
      title: 'Cereals & Breakfast',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Corn Flakes',
          price: '₹185',
          icon: Icons.breakfast_dining_outlined,
          color: Color(0xFFF59E0B),
        ),
        ProductItem(
          name: 'Oats 1kg',
          price: '₹149',
          icon: Icons.rice_bowl_outlined,
          color: Color(0xFFCA8A04),
        ),
        ProductItem(
          name: 'Muesli Mix',
          price: '₹220',
          icon: Icons.egg_alt_outlined,
          color: Color(0xFF65A30D),
        ),
        ProductItem(
          name: 'Bread Loaf',
          price: '₹45',
          icon: Icons.bakery_dining,
          color: Color(0xFFD97706),
        ),
      ],
    ),
    ShopCategory(
      title: 'Chips & Namkeen',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Potato Chips',
          price: '₹20',
          icon: Icons.fastfood_outlined,
          color: Color(0xFFEAB308),
        ),
        ProductItem(
          name: 'Bhujia Pack',
          price: '₹55',
          icon: Icons.lunch_dining_outlined,
          color: Color(0xFFF97316),
        ),
        ProductItem(
          name: 'Mixture',
          price: '₹40',
          icon: Icons.ramen_dining_outlined,
          color: Color(0xFFEA580C),
        ),
        ProductItem(
          name: 'Nachos',
          price: '₹65',
          icon: Icons.local_pizza_outlined,
          color: Color(0xFFDC2626),
        ),
      ],
    ),
    ShopCategory(
      title: 'Grains & Cereals',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Chakki Atta 5kg',
          price: '₹245',
          icon: Icons.grain,
          color: Color(0xFFD97706),
        ),
        ProductItem(
          name: 'Basmati Rice',
          price: '₹320',
          icon: Icons.rice_bowl,
          color: Color(0xFFCA8A04),
        ),
        ProductItem(
          name: 'Toor Dal',
          price: '₹160',
          icon: Icons.spa,
          color: Color(0xFFA16207),
        ),
        ProductItem(
          name: 'Rava / Sooji',
          price: '₹55',
          icon: Icons.circle,
          color: Color(0xFFFBBF24),
        ),
      ],
    ),
    ShopCategory(
      title: 'Herbs & Spices',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Turmeric Powder',
          price: '₹55',
          icon: Icons.grass,
          color: Color(0xFFEAB308),
        ),
        ProductItem(
          name: 'Cumin Seeds',
          price: '₹60',
          icon: Icons.eco,
          color: Color(0xFF65A30D),
        ),
        ProductItem(
          name: 'Coriander Powder',
          price: '₹45',
          icon: Icons.local_florist,
          color: Color(0xFF16A34A),
        ),
        ProductItem(
          name: 'Chilli Powder',
          price: '₹50',
          icon: Icons.local_fire_department,
          color: Color(0xFFEF4444),
        ),
      ],
    ),
    ShopCategory(
      title: 'Masala & Dry Fruits',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Garam Masala',
          price: '₹85',
          icon: Icons.spa_outlined,
          color: Color(0xFFDC2626),
        ),
        ProductItem(
          name: 'Almonds 250g',
          price: '₹299',
          icon: Icons.park,
          color: Color(0xFF92400E),
        ),
        ProductItem(
          name: 'Cashews 250g',
          price: '₹349',
          icon: Icons.brightness_1,
          color: Color(0xFFB45309),
        ),
        ProductItem(
          name: 'Raisins Pack',
          price: '₹120',
          icon: Icons.bubble_chart,
          color: Color(0xFF7C2D12),
        ),
      ],
    ),
    ShopCategory(
      title: 'Oils & Ghee',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Sunflower Oil 1L',
          price: '₹189',
          icon: Icons.water_drop,
          color: Color(0xFFFBBF24),
        ),
        ProductItem(
          name: 'Mustard Oil',
          price: '₹210',
          icon: Icons.opacity,
          color: Color(0xFFCA8A04),
        ),
        ProductItem(
          name: 'Pure Ghee 500ml',
          price: '₹320',
          icon: Icons.breakfast_dining,
          color: Color(0xFFF59E0B),
        ),
        ProductItem(
          name: 'Olive Oil',
          price: '₹450',
          icon: Icons.water_drop_outlined,
          color: Color(0xFF84CC16),
        ),
      ],
    ),
    ShopCategory(
      title: 'Sauces & Spreads',
      topTab: 'Grocery',
      tint: AppColors.categoryTint,
      products: const [
        ProductItem(
          name: 'Tomato Ketchup',
          price: '₹95',
          icon: Icons.liquor,
          color: Color(0xFFDC2626),
        ),
        ProductItem(
          name: 'Chocolate Spread',
          price: '₹199',
          icon: Icons.cookie,
          color: Color(0xFF78350F),
        ),
        ProductItem(
          name: 'Mayonnaise',
          price: '₹120',
          icon: Icons.egg,
          color: Color(0xFFFDE68A),
        ),
        ProductItem(
          name: 'Green Chutney',
          price: '₹45',
          icon: Icons.eco_outlined,
          color: Color(0xFF16A34A),
        ),
      ],
    ),
    ShopCategory(
      title: 'Skincare',
      topTab: 'Beauty',
      tint: const Color(0xFFFCE7F3),
      products: const [
        ProductItem(
          name: 'Face Wash',
          price: '₹149',
          icon: Icons.soap,
          color: Color(0xFFEC4899),
        ),
        ProductItem(
          name: 'Moisturizer',
          price: '₹199',
          icon: Icons.spa,
          color: Color(0xFFDB2777),
        ),
        ProductItem(
          name: 'Lip Balm',
          price: '₹89',
          icon: Icons.favorite,
          color: Color(0xFFF43F5E),
        ),
        ProductItem(
          name: 'Sunscreen',
          price: '₹299',
          icon: Icons.wb_sunny_outlined,
          color: Color(0xFFF59E0B),
        ),
      ],
    ),
    ShopCategory(
      title: 'Mobiles & Gadgets',
      topTab: 'Electronics',
      tint: const Color(0xFFEEF2FF),
      products: const [
        ProductItem(
          name: 'Earbuds',
          price: '₹1299',
          icon: Icons.headphones,
          color: Color(0xFF4F46E5),
        ),
        ProductItem(
          name: 'Power Bank',
          price: '₹999',
          icon: Icons.battery_charging_full,
          color: Color(0xFF2563EB),
        ),
        ProductItem(
          name: 'USB Cable',
          price: '₹199',
          icon: Icons.cable,
          color: Color(0xFF64748B),
        ),
        ProductItem(
          name: 'Phone Stand',
          price: '₹249',
          icon: Icons.phone_android,
          color: Color(0xFF0EA5E9),
        ),
      ],
    ),
    ShopCategory(
      title: 'Men & Women',
      topTab: 'Fashion',
      tint: const Color(0xFFF3E8FF),
      products: const [
        ProductItem(
          name: 'Cotton T-Shirt',
          price: '₹399',
          icon: Icons.checkroom,
          color: Color(0xFF7C3AED),
        ),
        ProductItem(
          name: 'Casual Shirt',
          price: '₹699',
          icon: Icons.dry_cleaning,
          color: Color(0xFF8B5CF6),
        ),
        ProductItem(
          name: 'Kurti',
          price: '₹549',
          icon: Icons.woman,
          color: Color(0xFFA855F7),
        ),
        ProductItem(
          name: 'Cap',
          price: '₹199',
          icon: Icons.face,
          color: Color(0xFF6366F1),
        ),
      ],
    ),
    ShopCategory(
      title: 'Toys & More',
      topTab: 'Kids',
      tint: const Color(0xFFFFF7ED),
      products: const [
        ProductItem(
          name: 'Building Blocks',
          price: '₹499',
          icon: Icons.toys,
          color: Color(0xFFF97316),
        ),
        ProductItem(
          name: 'Story Book',
          price: '₹149',
          icon: Icons.menu_book,
          color: Color(0xFFEA580C),
        ),
        ProductItem(
          name: 'Soft Toy',
          price: '₹299',
          icon: Icons.pets,
          color: Color(0xFFFB923C),
        ),
        ProductItem(
          name: 'Color Kit',
          price: '₹179',
          icon: Icons.palette,
          color: Color(0xFFEF4444),
        ),
      ],
    ),
  ];

  static const List<StoreInfo> stores = [
    StoreInfo(
      name: 'SmartMart Express',
      distance: '0.4 km',
      time: '10 mins',
      rating: 4.6,
      category: 'Grocery',
    ),
    StoreInfo(
      name: 'Fresh Mart',
      distance: '0.8 km',
      time: '15 mins',
      rating: 4.4,
      category: 'Grocery',
    ),
    StoreInfo(
      name: 'Tech Zone',
      distance: '1.2 km',
      time: '20 mins',
      rating: 4.3,
      category: 'Electronics',
    ),
    StoreInfo(
      name: 'Style Hub',
      distance: '1.5 km',
      time: '25 mins',
      rating: 4.5,
      category: 'Fashion',
    ),
  ];

  static List<ProductItem> get allProducts {
    final items = <ProductItem>[];
    for (final c in categories) {
      items.addAll(c.products);
    }
    return items;
  }

  static List<ShopCategory> categoriesForTab(String tab) {
    if (tab == 'All') return categories;
    return categories.where((c) => c.topTab == tab).toList();
  }
}
