import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.name,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: SizedBox(
        width: 75,

        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,

              decoration: BoxDecoration(
                color: selected
                    ? Colors.deepOrange.shade50
                    : Colors.grey.shade100,

                borderRadius: BorderRadius.circular(15),

                border: Border.all(
                  color: selected
                      ? Colors.deepOrange
                      : Colors.transparent,
                ),
              ),

              child: Icon(
                icon,

                color: selected
                    ? Colors.deepOrange
                    : Colors.grey.shade700,

                size: 28,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              name,

              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                fontSize: 12,

                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}