import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:io';

// widget dari slide 14
final ValueNotifier<int> nilaiLagu = ValueNotifier<int>(0);

class DaftarWidget extends StatelessWidget {
  const DaftarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // widget dari slide 5
      appBar: AppBar(title: const Text('Daftar Lagu')), // widget dari slide 5

      body: SafeArea(
        // widget dari slide 5
        child: SingleChildScrollView(
          // widget dari slide 10
          child: Padding(
            // widget dari slide 4
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  // widget dari slide 4
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.red),
                  child: Row(
                    // widget dari slide 4
                    children: [
                      const Icon(
                        // widget dari slide 6
                        Icons.library_music,
                        color: Colors.white,
                        size: 35,
                      ),

                      const SizedBox(width: 12), // widget dari slide 4

                      Expanded(
                        // widget dari slide 4
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              // widget dari slide 6
                              'Daftar Lagu',
                              style: TextStyle(
                                // widget dari slide 6
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Kumpulan lagu favorit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // widget dari slide 5
                const Text(
                  'Center',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Center(
                  child: Text(
                    'Daftar Lagu Favorit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 6
                const Text(
                  'RichText',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Lagu ',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Favorit',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 6
                const Text(
                  'SelectableText',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SelectableText(
                  'Tiara Andini',
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 10),

                // widget dari slide 6
                const Text(
                  'ImageIcon',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const ImageIcon(
                  AssetImage('assets/images/lagu.png'),
                  size: 100,
                ),

                const SizedBox(height: 10),

                // widget dari slide 7
                const Text(
                  'TextButton',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('Kembali'),
                ),

                // widget dari slide 7
                const Text(
                  'OutlinedButton',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text('Informasi'),
                          content: Text('Ini adalah lagu favorit.'),
                        );
                      },
                    );
                  },
                  child: const Text('Informasi'),
                ),

                // widget dari slide 7
                const Text(
                  'PopupMenuButton',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Putar',
                      child: Text('Putar Lagu'),
                    ),
                    const PopupMenuItem(
                      value: 'Favorit',
                      child: Text('Tambah Favorit'),
                    ),
                  ],
                  child: const Text('Menu Lagu'),
                ),

                // widget dari slide 7
                const Text(
                  'ButtonBar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                OverflowBar(
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Batal')),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Simpan'),
                    ),
                  ],
                ),

                // widget dari slide 8
                const Text(
                  'TextFormField',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama Lagu',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 8
                const Text(
                  'Form',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Form(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nama Penyanyi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const PilihanLagu(),

                const SizedBox(height: 10),

                // widget dari slide 8
                const Text(
                  'DatePicker',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                  },
                  child: const Text('Pilih Tanggal'),
                ),

                // widget dari slide 8
                const Text(
                  'TimePicker',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  child: const Text('Pilih Waktu'),
                ),

                // widget dari slide 9
                const Text(
                  'CircleAvatar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),

                const SizedBox(height: 10),

                // widget dari slide 9
                const Text(
                  'Card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: const [
                        Text(
                          'Janji Setia',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Tiara Andini'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 9
                const Text(
                  'ClipRRect',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 200,
                    height: 100,
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Janji Setia',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 9
                const Text(
                  'FadeInImage',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  width: 200,
                  height: 100,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/lagu.png',
                    image: 'assets/images/lagu.png',
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 9
                const Text(
                  'Hero',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Hero(
                  tag: 'gambar-lagu',
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // widget dari slide 10
                const Text(
                  'ListView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 150,
                  child: ListView(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.music_note),
                        title: Text('Janji Setia'),
                      ),
                      ListTile(
                        leading: Icon(Icons.music_note),
                        title: Text('Lagu Kedua'),
                      ),
                      ListTile(
                        leading: Icon(Icons.music_note),
                        title: Text('Lagu Ketiga'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 10
                const Text(
                  'GridView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 180,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: const [
                      Card(child: Center(child: Text('Lagu 1'))),
                      Card(child: Center(child: Text('Lagu 2'))),
                      Card(child: Center(child: Text('Lagu 3'))),
                      Card(child: Center(child: Text('Lagu 4'))),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 10
                const Text(
                  'Wrap',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Wrap(
                  spacing: 10,
                  children: const [
                    Chip(label: Text('Pop')),
                    Chip(label: Text('Rock')),
                    Chip(label: Text('Jazz')),
                    Chip(label: Text('Dangdut')),
                  ],
                ),

                const SizedBox(height: 10),

                // widget dari slide 10
                const Text(
                  'CustomScrollView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 150,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(const [
                          ListTile(title: Text('Lagu A')),
                          ListTile(title: Text('Lagu B')),
                          ListTile(title: Text('Lagu C')),
                        ]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 10
                const Text(
                  'PageView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 150,
                  child: PageView(
                    children: [
                      Container(
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            'Halaman 1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'Halaman 2',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 10
                SizedBox(
                  height: 150,
                  child: Scrollbar(
                    child: ListView(
                      children: const [
                        ListTile(title: Text('Lagu 1')),
                        ListTile(title: Text('Lagu 2')),
                        ListTile(title: Text('Lagu 3')),
                        ListTile(title: Text('Lagu 4')),
                        ListTile(title: Text('Lagu 5')),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // widget dari slide 10
                SizedBox(
                  height: 150,
                  child: ReorderableListView(
                    children: const [
                      ListTile(key: ValueKey('lagu1'), title: Text('Lagu 1')),
                      ListTile(key: ValueKey('lagu2'), title: Text('Lagu 2')),
                      ListTile(key: ValueKey('lagu3'), title: Text('Lagu 3')),
                    ],
                    onReorder: (oldIndex, newIndex) {},
                  ),
                ),

                const SizedBox(height: 20),

                // widget dari slide 11
                const Text(
                  'Navigator',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                // widget dari slide 11
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(title: Text('Halaman Baru')),
                            body: Center(
                              child: Text('Ini halaman dari Navigator'),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Buka Halaman'),
                ),

                const SizedBox(height: 20),

                // widget dari slide 11
                const Text(
                  'NavigationRail',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                // widget dari slide 11
                SizedBox(
                  height: 200,
                  child: Row(
                    children: [
                      NavigationRail(
                        selectedIndex: 0,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.music_note),
                            label: Text('Lagu'),
                          ),
                        ],
                      ),

                      const Expanded(
                        child: Center(child: Text('Halaman Lagu')),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // widget dari slide 11
                const Text(
                  'TabBar & TabBarView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                // widget dari slide 11
                DefaultTabController(
                  length: 2,
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: 'Lagu'),
                            Tab(text: 'Penyanyi'),
                          ],
                        ),

                        const Expanded(
                          child: TabBarView(
                            children: [
                              Center(child: Text('Daftar Lagu')),
                              Center(child: Text('Daftar Penyanyi')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // widget dari slide 11
                const Text(
                  'PageRouteBuilder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                // widget dari slide 11
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Scaffold(
                            appBar: AppBar(title: Text('PageRouteBuilder')),
                            body: Center(child: Text('Halaman Baru')),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Buka PageRouteBuilder'),
                ),

                // widget dari slide 12
                const Text(
                  'AlertDialog',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text('Apakah kamu ingin melanjutkan?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ya'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Tampilkan AlertDialog'),
                ),

                const SizedBox(height: 20),

                // widget dari slide 12
                const Text(
                  'Snackbar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lagu berhasil disimpan!')),
                    );
                  },
                  child: const Text('Tampilkan Snackbar'),
                ),

                const SizedBox(height: 20),

                // widget dari slide 12
                const Text(
                  'Tooltip',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const Tooltip(
                  message: 'Tombol untuk memutar lagu',
                  child: Icon(Icons.play_circle, size: 50),
                ),

                const SizedBox(height: 20),

                // widget dari slide 12
                const Text(
                  'CircularProgressIndicator',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const CircularProgressIndicator(),

                const SizedBox(height: 20),

                // widget dari slide 12
                const Text(
                  'showDialog',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Informasi Lagu'),
                          content: const Text(
                            'Ini adalah informasi tentang lagu.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Tutup'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Buka showDialog'),
                ),

                const SizedBox(height: 20),

                // widget dari slide 12
                const Text(
                  'Banner',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                MaterialBanner(
                  content: const Text('Ada lagu baru yang tersedia.'),
                  leading: const Icon(Icons.music_note),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                      },
                      child: const Text('Tutup'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // widget dari slide 12
                const Text(
                  'showModalBottomSheet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                // widget dari slide 12
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 150,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Menu Lagu'),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tutup'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Buka Bottom Sheet'),
                ),

                const SizedBox(height: 20),

                // widget dari slide 12
                const Text(
                  'LinearProgressIndicator',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                // widget dari slide 12
                const LinearProgressIndicator(),

                const SizedBox(height: 20),

                const AnimasiWidget(),

                const SizedBox(height: 20),

                // widget dari slide 14
                const Text(
                  'StreamBuilder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                StreamBuilder<int>(
                  stream: Stream.periodic(
                    const Duration(seconds: 1),
                    (angka) => angka,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text('Menunggu data...');
                    }

                    return Text(
                      'Angka: ${snapshot.data}',
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // widget dari slide 14
                const Text(
                  'InheritedWidget',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                LaguData(
                  namaLagu: 'Janji Setia',
                  child: Builder(
                    builder: (context) {
                      final lagu = LaguData.of(context);

                      return Text(
                        'Lagu: ${lagu.namaLagu}',
                        style: const TextStyle(fontSize: 20),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // widget dari slide 14
                const Text(
                  'FutureBuilder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                FutureBuilder<String>(
                  future: Future.delayed(
                    const Duration(seconds: 2),
                    () => 'Janji Setia - Tiara Andini',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    return Text(
                      'Lagu: ${snapshot.data}',
                      style: const TextStyle(fontSize: 18),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // widget dari slide 14
                const Text(
                  'ValueListenableBuilder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ValueListenableBuilder<int>(
                  valueListenable: ValueNotifier<int>(0),
                  builder: (context, value, child) {
                    return Text(
                      'Nilai: $value',
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // widget dari slide 14
                const Text(
                  'ValueListenableBuilder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                ValueListenableBuilder<int>(
                  valueListenable: nilaiLagu,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        Text(
                          'Nilai: $value',
                          style: const TextStyle(fontSize: 20),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            nilaiLagu.value++;
                          },
                          child: const Text('Tambah Nilai'),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                const KameraGpsWidget(),

                const SizedBox(height: 20),

                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Row(
                        children: [
                          Stack(
                            // widget dari slide 4
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(color: Colors.red),
                              ),

                              const Positioned(
                                left: 17,
                                top: 17,
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 12),

                          Flexible(
                            // widget dari slide 4
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Janji Setia',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Tiara Andini'),
                              ],
                            ),
                          ),

                          // widget dari slide 5
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () {
                                // widget dari slide 5
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context.go('/');
                                          },
                                          child: const Text(
                                            'Kembali Ke Halaman Utama',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lagu Kedua',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Penyanyi'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(color: Colors.green),
                            child: const Icon(
                              Icons.music_note,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lagu Ketiga',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Penyanyi'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PilihanLagu extends StatefulWidget {
  const PilihanLagu({super.key});

  @override
  State<PilihanLagu> createState() => _PilihanLaguState();
}

class _PilihanLaguState extends State<PilihanLagu> {
  bool isFavorite = false;

  String jenisLagu = 'Pop';

  double volume = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // widget dari slide 8
        const Text(
          'Checkbox',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        CheckboxListTile(
          title: const Text('Tambahkan ke Favorit'),
          value: isFavorite,
          onChanged: (value) {
            setState(() {
              isFavorite = value!;
            });
          },
        ),

        // widget dari slide 8
        const Text(
          'Radio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        RadioListTile<String>(
          title: const Text('Pop'),
          value: 'Pop',
          groupValue: jenisLagu,
          onChanged: (value) {
            setState(() {
              jenisLagu = value!;
            });
          },
        ),

        RadioListTile<String>(
          title: const Text('Rock'),
          value: 'Rock',
          groupValue: jenisLagu,
          onChanged: (value) {
            setState(() {
              jenisLagu = value!;
            });
          },
        ),

        // widget dari slide 8
        const Text(
          'Slider',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Volume: ${volume.toInt()}'),

        Slider(
          value: volume,
          min: 0,
          max: 100,
          onChanged: (value) {
            setState(() {
              volume = value;
            });
          },
        ),
      ],
    );
  }
}

class AnimasiWidget extends StatefulWidget {
  const AnimasiWidget({super.key});

  @override
  State<AnimasiWidget> createState() => _AnimasiWidgetState();
}

class _AnimasiWidgetState extends State<AnimasiWidget>
    with SingleTickerProviderStateMixin {
  bool berubah = false;

  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // widget dari slide 13
        const Text(
          'AnimatedContainer',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              berubah = !berubah;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: berubah ? 200 : 100,
            height: 80,
            color: berubah ? Colors.blue : Colors.red,
            alignment: Alignment.center,
            child: const Text(
              'Klik Saya',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // widget dari slide 13
        const Text(
          'AnimatedOpacity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: berubah ? 0.3 : 1.0,
          child: const Icon(Icons.music_note, size: 70, color: Colors.red),
        ),

        const SizedBox(height: 20),

        // widget dari slide 13
        const Text(
          'FadeTransition',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        FadeTransition(
          opacity: fadeAnimation,
          child: const Text('Lagu Favorit', style: TextStyle(fontSize: 20)),
        ),

        const SizedBox(height: 20),

        // widget dari slide 13
        const Text(
          'AnimatedSwitcher',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: berubah
              ? const Text(
                  'Lagu Dipilih',
                  key: ValueKey('dipilih'),
                  style: TextStyle(fontSize: 20, color: Colors.green),
                )
              : const Text(
                  'Pilih Lagu',
                  key: ValueKey('belum'),
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
        ),

        const SizedBox(height: 20),

        // widget dari slide 13
        const Text(
          'ScaleTransition',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        ScaleTransition(
          scale: scaleAnimation,
          child: const Icon(Icons.play_circle, size: 70, color: Colors.blue),
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
            controller.reset();
            controller.forward();
          },
          child: const Text('Jalankan Animasi'),
        ),
      ],
    );
  }
}

// widget dari slide 14
class LaguData extends InheritedWidget {
  final String namaLagu;

  const LaguData({super.key, required this.namaLagu, required super.child});

  static LaguData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LaguData>()!;
  }

  @override
  bool updateShouldNotify(LaguData oldWidget) {
    return namaLagu != oldWidget.namaLagu;
  }
}

class KameraGpsWidget extends StatefulWidget {
  const KameraGpsWidget({super.key});

  @override
  State<KameraGpsWidget> createState() => _KameraGpsWidgetState();
}

class _KameraGpsWidgetState extends State<KameraGpsWidget> {
  XFile? foto;
  String lokasi = 'Belum ada lokasi';

  // Widget Kamera
  Future<void> ambilFoto() async {
    final hasil = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      foto = hasil;
    });
  }

  // Widget GPS
  Future<void> ambilLokasi() async {
    Position posisi = await Geolocator.getCurrentPosition();

    setState(() {
      lokasi =
          'Latitude: ${posisi.latitude}\n'
          'Longitude: ${posisi.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Kamera',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        ElevatedButton.icon(
          onPressed: ambilFoto,
          icon: const Icon(Icons.camera_alt),
          label: const Text('Akses Kamera'),
        ),

        if (foto != null) Image.file(File(foto!.path), width: 200, height: 200),

        const SizedBox(height: 20),

        const Text(
          'GPS',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        ElevatedButton.icon(
          onPressed: ambilLokasi,
          icon: const Icon(Icons.location_on),
          label: const Text('Ambil Lokasi'),
        ),

        Text(lokasi),
      ],
    );
  }
}
