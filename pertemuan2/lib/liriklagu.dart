class Liriklagu {
  String? judul;
  String? lirik1;
  String? lirik2;
  String? penyanyi;

  Liriklagu ({required this.judul, required this.lirik1, required this.lirik2, required this.penyanyi});

  void tampilkanLagu() {
    print('Nama: $judul');
    print('Umur: $lirik1');
    print('Kelas: $lirik2');
    print('Penyanyi: $penyanyi');
  }
}