import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 45,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Guest User',

              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ListTile(
              leading: const Icon(
                Icons.person_outline,
              ),
              title: const Text('My Account'),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(
                Icons.shopping_bag_outlined,
              ),
              title: const Text('My Orders'),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
              ),
              title: const Text('Settings'),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}