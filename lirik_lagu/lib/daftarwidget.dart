import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DaftarWidget extends StatelessWidget {
  const DaftarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Widget'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Daftar Widget Flutter',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Berikut adalah beberapa widget yang digunakan dalam aplikasi ini.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.text_fields,
                color: Colors.red,
              ),
              title: const Text('Text'),
              subtitle: const Text(
                'Digunakan untuk menampilkan tulisan.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.image,
                color: Colors.red,
              ),
              title: const Text('Image'),
              subtitle: const Text(
                'Digunakan untuk menampilkan gambar.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.search,
                color: Colors.red,
              ),
              title: const Text('TextField'),
              subtitle: const Text(
                'Digunakan untuk memasukkan atau mencari data.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.red,
              ),
              title: const Text('DropdownButton'),
              subtitle: const Text(
                'Digunakan untuk memilih salah satu pilihan.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.smart_button,
                color: Colors.red,
              ),
              title: const Text('ElevatedButton'),
              subtitle: const Text(
                'Digunakan untuk membuat tombol.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.toggle_on,
                color: Colors.red,
              ),
              title: const Text('Switch'),
              subtitle: const Text(
                'Digunakan untuk pilihan hidup atau mati.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.linear_scale,
                color: Colors.red,
              ),
              title: const Text('Slider'),
              subtitle: const Text(
                'Digunakan untuk memilih nilai dalam suatu rentang.',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.menu,
                color: Colors.red,
              ),
              title: const Text('Drawer'),
              subtitle: const Text(
                'Digunakan untuk membuat menu navigasi samping.',
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Kembali ke Lagu'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
          ),
        ],
      ),
    );
  }
}