import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 15),

            Text(
              'Your wishlist is empty',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}