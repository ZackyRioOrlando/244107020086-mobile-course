import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,

      elevation: 5,

      selectedIndex: currentIndex,

      onDestinationSelected: onTap,

      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),

        NavigationDestination(
          icon: Icon(Icons.category_outlined),
          selectedIcon: Icon(Icons.category),
          label: 'Kategori',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.shopping_cart_outlined,
          ),
          selectedIcon: Icon(
            Icons.shopping_cart,
          ),
          label: 'Keranjang',
        ),

        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Saya',
        ),
      ],
    );
  }
}