import 'package:flutter/material.dart';
import 'package:smartcart/data/app_data.dart';
import 'package:smartcart/screens/category_detail/category_detail_screen.dart';
import 'package:smartcart/state/cart_controller.dart';
import 'package:smartcart/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    this.startEditing = false,
    this.startWithVoice = false,
  });

  final bool startEditing;
  final bool startWithVoice;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.startWithVoice) {
        _controller.text = 'tea';
        setState(() => _query = 'tea');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Listening... found "tea"'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<ProductItem> get _results {
    if (_query.trim().isEmpty) return AppData.allProducts;
    final q = _query.toLowerCase();
    return AppData.allProducts
        .where((p) => p.name.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: const InputDecoration(
            hintText: 'Search "tea"',
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _controller.clear();
              setState(() => _query = '');
              _focusNode.requestFocus();
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: cartController,
        builder: (context, _) {
          final results = _results;
          if (results.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final product = results[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoryDetailScreen(
                        title: product.name,
                        products: [product],
                      ),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.cardBorder),
                ),
                tileColor: Colors.white,
                leading: CircleAvatar(
                  backgroundColor: product.color.withValues(alpha: 0.15),
                  child: Icon(product.icon, color: product.color),
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(product.price),
                trailing: IconButton(
                  onPressed: () {
                    cartController.add(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  color: AppColors.primary,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
