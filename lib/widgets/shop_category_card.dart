import 'package:flutter/material.dart';
import 'package:smartcart/data/app_data.dart';
import 'package:smartcart/theme/app_colors.dart';

class ShopCategoryCard extends StatelessWidget {
  const ShopCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  final ShopCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final preview = category.products.take(3).toList();

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: category.tint,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        for (var i = 0; i < 2; i++) ...[
                          if (i < preview.length)
                            Expanded(child: _thumb(preview[i]))
                          else
                            const Expanded(child: SizedBox.shrink()),
                          if (i == 0) const SizedBox(width: 4),
                        ],
                      ],
                    ),
                  ),
                  if (preview.length > 2) ...[
                    const SizedBox(height: 4),
                    Expanded(child: _thumb(preview[2])),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            category.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _thumb(ProductItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(item.icon, size: 18, color: item.color),
    );
  }
}
