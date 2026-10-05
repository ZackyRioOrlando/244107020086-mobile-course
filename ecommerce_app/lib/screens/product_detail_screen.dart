import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ==========================================
      // APP BAR
      // ==========================================

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,

        title: const Text(
          'Detail Produk',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),

      // ==========================================
      // BODY
      // ==========================================

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ==================================
                  // PRODUCT IMAGE
                  // ==================================

                  Container(
                    color: Colors.white,

                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,

                          child: Image.network(
                            product.image,

                            width: double.infinity,

                            fit: BoxFit.cover,

                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,

                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 60,
                                ),
                              );
                            },
                          ),
                        ),

                        // Favorite
                        Positioned(
                          right: 15,
                          bottom: 15,

                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite =
                                    !isFavorite;
                              });
                            },

                            child: Container(
                              padding:
                                  const EdgeInsets.all(10),

                              decoration:
                                  const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),

                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,

                                color: isFavorite
                                    ? Colors.red
                                    : Colors.black,

                                size: 24,
                              ),
                            ),
                          ),
                        ),

                        // Image Counter
                        Positioned(
                          bottom: 15,
                          left: 15,

                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.circular(6),
                            ),

                            child: const Text(
                              '1/5',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ==================================
                  // PRODUCT INFORMATION
                  // ==================================

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(16),

                    color: Colors.white,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        // Price
                        Text(
                          'Rp ${product.price.toStringAsFixed(0)}',

                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Product name
                        Text(
                          product.name,

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              product.rating.toString(),

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey,
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              '120+ Terjual',

                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ==================================
                  // VOUCHER
                  // ==================================

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(16),

                    color: Colors.white,

                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_offer,
                          color: Colors.deepOrange,
                        ),

                        const SizedBox(width: 10),

                        const Expanded(
                          child: Text(
                            'Voucher Toko',

                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color:
                                Colors.deepOrange.shade50,

                            borderRadius:
                                BorderRadius.circular(5),
                          ),

                          child: const Text(
                            'Diskon 10%',
                            style: TextStyle(
                              color:
                                  Colors.deepOrange,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ==================================
                  // SHIPPING
                  // ==================================

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(16),

                    color: Colors.white,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Pengiriman',

                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color:
                                  Colors.deepOrange,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [
                                  const Text(
                                    'Dikirim dari',
                                    style: TextStyle(
                                      color:
                                          Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 3,
                                  ),

                                  const Text(
                                    'Surabaya, Jawa Timur',

                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Icon(
                              Icons.local_shipping_outlined,
                              color:
                                  Colors.deepOrange,
                            ),

                            const SizedBox(width: 10),

                            const Expanded(
                              child: Text(
                                'Gratis Ongkir dengan voucher',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ==================================
                  // STORE
                  // ==================================

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(16),

                    color: Colors.white,

                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,

                          decoration:
                              const BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.store,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              Text(
                                'ShopNow Official Store',

                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                'Online • Aktif sekarang',

                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        OutlinedButton(
                          onPressed: () {},

                          child: const Text(
                            'Kunjungi',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ==================================
                  // QUANTITY
                  // ==================================

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(16),

                    color: Colors.white,

                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Jumlah',

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          decoration:
                              BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),

                            borderRadius:
                                BorderRadius.circular(6),
                          ),

                          child: Row(
                            children: [
                              IconButton(
                                onPressed:
                                    quantity > 1
                                        ? () {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        : null,

                                icon: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),

                              Text(
                                quantity.toString(),

                                style: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },

                                icon: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ==================================
                  // DESCRIPTION
                  // ==================================

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(16),

                    color: Colors.white,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Deskripsi Produk',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          product.description,

                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          '• Produk berkualitas tinggi\n'
                          '• Cocok digunakan sehari-hari\n'
                          '• Packing aman dan rapi\n'
                          '• Produk sesuai dengan deskripsi',

                          style: TextStyle(
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // ==========================================
          // BOTTOM ACTION
          // ==========================================

          Container(
            padding: const EdgeInsets.fromLTRB(
              10,
              10,
              10,
              10,
            ),

            decoration: BoxDecoration(
              color: Colors.white,

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.08,
                  ),

                  blurRadius: 8,

                  offset: const Offset(0, -2),
                ),
              ],
            ),

            child: Row(
              children: [
                // Chat
                Container(
                  width: 48,
                  height: 48,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepOrange,
                    ),

                    borderRadius:
                        BorderRadius.circular(8),
                  ),

                  child: const Icon(
                    Icons.chat_outlined,
                    color: Colors.deepOrange,
                  ),
                ),

                const SizedBox(width: 8),

                // Add cart
                Expanded(
                  child: SizedBox(
                    height: 48,

                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Produk ditambahkan ke keranjang',
                            ),
                          ),
                        );
                      },

                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),

                      label: const Text(
                        'Keranjang',
                      ),

                      style:
                          OutlinedButton.styleFrom(
                        foregroundColor:
                            Colors.deepOrange,

                        side: const BorderSide(
                          color: Colors.deepOrange,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Buy
                Expanded(
                  child: SizedBox(
                    height: 48,

                    child: ElevatedButton(
                      onPressed: () {},

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.deepOrange,

                        foregroundColor:
                            Colors.white,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),

                      child: const Text(
                        'Beli Sekarang',

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
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
  }
}