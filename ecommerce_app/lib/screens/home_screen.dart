import 'package:flutter/material.dart';

import '../data/products.dart';
import '../widgets/product_card.dart';
import '../widgets/category_item.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'All',
      'icon': Icons.apps,
    },
    {
      'name': 'Shoes',
      'icon': Icons.shopping_bag,
    },
    {
      'name': 'Electronics',
      'icon': Icons.phone_android,
    },
    {
      'name': 'Bags',
      'icon': Icons.backpack,
    },
    {
      'name': 'Audio',
      'icon': Icons.headphones,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts =
        selectedCategory == 'All'
            ? products
            : products
                .where(
                  (product) =>
                      product.category ==
                      selectedCategory,
                )
                .toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // =========================
            // HEADER
            // =========================

            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  16,
                ),

                color: Colors.deepOrange,

                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),

                        child: const TextField(
                          decoration:
                              InputDecoration(
                            hintText:
                                'Cari di ShopNow...',

                            prefixIcon: Icon(
                              Icons.search,
                            ),

                            border:
                                InputBorder.none,

                            contentPadding:
                                EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 28,
                    ),

                    const SizedBox(width: 12),

                    const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 27,
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // BANNER
            // =========================

            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(12),

                height: 150,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(12),

                  gradient: const LinearGradient(
                    colors: [
                      Colors.deepOrange,
                      Colors.orange,
                    ],
                  ),
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(20),

                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            const Text(
                              'FLASH SALE',

                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              'Diskon hingga 50%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),

                              decoration:
                                  BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius
                                        .circular(6),
                              ),

                              child: const Text(
                                'Belanja Sekarang',

                                style: TextStyle(
                                  color:
                                      Colors.deepOrange,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.local_mall,
                        color: Colors.white,
                        size: 90,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // =========================
            // CATEGORY
            // =========================

            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),

                color: Colors.white,

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(
                        horizontal: 16,
                      ),

                      child: Text(
                        'Kategori',

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      height: 90,

                      child: ListView.builder(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 12,
                        ),

                        scrollDirection:
                            Axis.horizontal,

                        itemCount:
                            categories.length,

                        itemBuilder:
                            (context, index) {
                          final category =
                              categories[index];

                          final selected =
                              category['name'] ==
                                  selectedCategory;

                          return CategoryItem(
                            name:
                                category['name'],

                            icon:
                                category['icon'],

                            selected:
                                selected,

                            onTap: () {
                              setState(() {
                                selectedCategory =
                                    category['name'];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // FLASH SALE TITLE
            // =========================

            SliverToBoxAdapter(
              child: Container(
                margin:
                    const EdgeInsets.only(
                  top: 10,
                ),

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),

                color: Colors.white,

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.flash_on,
                          color:
                              Colors.deepOrange,
                        ),

                        const SizedBox(width: 5),

                        const Text(
                          'Flash Sale',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {},

                      child: const Text(
                        'Lihat Semua',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // PRODUCTS
            // =========================

            SliverPadding(
              padding:
                  const EdgeInsets.all(12),

              sliver: SliverGrid(
                delegate:
                    SliverChildBuilderDelegate(
                  (context, index) {
                    final product =
                        filteredProducts[index];

                    return ProductCard(
                      product: product,

                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(
                              product: product,
                            ),
                          ),
                        );
                      },
                    );
                  },

                  childCount:
                      filteredProducts.length,
                ),

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  crossAxisSpacing: 10,

                  mainAxisSpacing: 10,

                  childAspectRatio: 0.65,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}