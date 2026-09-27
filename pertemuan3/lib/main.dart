import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'liriklagu.dart';
import 'widget.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const Zacky();
      },
    ),
    GoRoute(
      path: '/daftar-widget',
      builder: (context, state) {
        return const DaftarWidget();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 76, 0, 208),
        ),
      ),
      routerConfig: router,
    );
  }
}

class Zacky extends StatelessWidget {
  const Zacky({super.key});

  @override
  Widget build(BuildContext context) {
    final lagu = Liriklagu(
      judul: 'Janji Setia',
      lirik1: 'Kini aku mengerti, semua ini terjadi. Tak dipungkiri, hanya kamu yang kumiliki.  Bumi di kala sunyi, kamu takkan sendiri. Aku di sini menantimu kembali. Andai saja ku bisa. Genggam tanganmu. Takkan ada kata rindu. Di dalam hatiku. Tahukah dirimu betapa diriku. Merindukan hadirmu ada di sini?. Percayalah, Kasih. Jarak dan waktu tak mampu menghapus. Janji setia menjaga hati. Andai saja ku bisa. Genggam tanganmu. Takkan ada kata rindu. Di dalam hatiku, oh-oh',
      lirik2: 'Tahukah dirimu betapa diriku. Merindukan hadirmu ada di sini?.Percayalah, Kasih. Jarak dan waktu tak mampu menghapus (janganlah kauhapus). Janji setia menjaga hati Hujan turun mewakili hati. Terpa angin gambarkan resahku, ho-oh. Namun, kini pelangi (dan kini pelangi). Datang menyinari kita. ho-oh. Merindukan hadirmu ada di sini? Percayalah, Kasih. Jarak dan waktu tak mampu menghapus. Janji setia menjaga hati. Merindukan hadirmu ada di sini? Percayalah, oh, Kasihku. Jarak dan waktu tak mampu menghapus. Janji setia menjaga hati. Ho-oh-oh-ho.',
      penyanyi: 'Tiara Andini',
    );
    return Scaffold(
      appBar: AppBar(title: Text('${lagu.judul} by ${lagu.penyanyi}')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 208, 0, 0)),
              child: Text(
                'Daftar Lagu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text('${lagu.judul}'),
              onTap: () {
                context.go('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.music_note),
              title: const Text('Daftar Widget'),
              onTap: () {
                context.go('/daftar-widget');
              },
            ),
            Switch(
              value: true,
              onChanged: (value) {
                print(value);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Cari lagu',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                Image.asset('assets/images/lagu.png', width: 450, height: 250),

                SizedBox(height: 20),
                Text(
                  '${lagu.lirik1}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                    wordSpacing: 3,
                    height: 2,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${lagu.lirik2}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                    wordSpacing: 3,
                    height: 2,
                  ),
                ),

                DropdownButton<String>(
                  value: '${lagu.judul}',
                  items: [
                    DropdownMenuItem(
                      value: '${lagu.judul}',
                      child: Text('${lagu.judul}'),
                    ),
                    DropdownMenuItem(
                      value: 'Daftar Lagu',
                      child: Text('Daftar Lagu'),
                    ),
                    DropdownMenuItem(
                      value: 'Daftar Lagu',
                      child: Text('Daftar Lagu'),
                    ),
                  ],
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 222, 13, 13),
        child: SizedBox(
          height: 90,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
                child: Slider(
                  value: 30,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    print('Progress: $value');
                  },
                ),
              ),

              Row(
                children: [
                  Text('${lagu.judul}'),
                  Icon(Icons.music_note),
                  SizedBox(width: 250),
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      print('Lagu sebelumnya');
                    },
                  ),
                  SizedBox(width: 100),
                  IconButton(
                    icon: Icon(Icons.pause),
                    onPressed: () {
                      print('Pause');
                    },
                  ),
                  SizedBox(width: 100),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () {
                      print('Lagu berikutnya');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
