import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(10),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.06,
              ),

              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // IMAGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),

                  child: AspectRatio(
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
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,

                  child: Container(
                    padding: const EdgeInsets.all(6),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // PRODUCT NAME
                  Text(
                    product.name,

                    maxLines: 2,

                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // PRICE
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // RATING + SOLD
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),

                      const SizedBox(width: 3),

                      Text(
                        product.rating.toString(),

                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        '120+ terjual',

                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}