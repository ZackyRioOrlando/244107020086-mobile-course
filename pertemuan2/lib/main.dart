import 'package:flutter/material.dart';

import 'liriklagu.dart';

void main() {
  runApp(const Zacky());
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 76, 0, 208),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('${lagu.judul} by ${lagu.penyanyi}')),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 20),
                Text('${lagu.judul}'),
                Icon(Icons.music_note),
                SizedBox(width: 250),
                Icon(Icons.skip_previous),
                SizedBox(width: 100),
                Icon(Icons.pause),
                SizedBox(width: 100),
                Icon(Icons.play_arrow),
                SizedBox(width: 100),
                Icon(Icons.skip_next),
              ],
            ),
          ),
          color: const Color.fromARGB(255, 222, 13, 13),
        ),
      ),
    );
  }
}
