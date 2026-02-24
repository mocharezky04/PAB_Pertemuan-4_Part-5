// lib/pages/product_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme_model.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import '../models/user_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Laptop Gaming',
      price: 15000000,
      imageUrl: 'https://picsum.photos/seed/laptop/300',
      category: 'Electronics',
    ),
    Product(
      id: '2',
      name: 'Smartphone Pro',
      price: 8000000,
      imageUrl: 'https://picsum.photos/seed/phone/300',
      category: 'Electronics',
    ),
    Product(
      id: '3',
      name: 'Wireless Headphones',
      price: 1500000,
      imageUrl: 'https://picsum.photos/seed/headphone/300',
      category: 'Audio',
    ),
    Product(
      id: '4',
      name: 'Smart Watch',
      price: 3000000,
      imageUrl: 'https://picsum.photos/seed/watch/300',
      category: 'Wearables',
    ),
    Product(
      id: '5',
      name: 'Camera DSLR',
      price: 12000000,
      imageUrl: 'https://picsum.photos/seed/camera/300',
      category: 'Photography',
    ),
    Product(
      id: '6',
      name: 'Tablet Pro',
      price: 7000000,
      imageUrl: 'https://picsum.photos/seed/tablet/300',
      category: 'Electronics',
    ),
  ];

  List<String> get _categories {
    final categories = _products.map((product) => product.category).toSet().toList()
      ..sort();
    return ['All', ...categories];
  }

  List<Product> get _filteredProducts {
    return _products.where((product) {
      final matchSearch =
          product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      return matchSearch && matchCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();
    final themeModel = context.watch<ThemeModel>();
    final filteredProducts = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products - ${user.name}'),
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeModel>().toggleTheme(),
            icon: Icon(
              themeModel.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          Selector<CartModel, int>(
            selector: (context, cart) => cart.itemCount,
            builder: (context, itemCount, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  if (itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$itemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search product by name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value.trim());
              },
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (_) {
                    setState(() => _selectedCategory = category);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: _categories.length,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text('No products found'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                product.imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image, size: 50),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product.category,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${product.price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        context.read<CartModel>().addItem(product);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${product.name} ditambahkan ke cart!',
                                            ),
                                            duration: const Duration(seconds: 1),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add_shopping_cart,
                                        size: 16,
                                      ),
                                      label: const Text(
                                        'Add',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
