class Liriklagu {
  String judul;
  String lirik1;
  String lirik2;
  String penyanyi;

  Liriklagu({
    required this.judul,
    required this.lirik1,
    required this.lirik2,
    required this.penyanyi,
  });

  void tampilkanLagu() {
    print('Nama: $judul');
    print('Lirik 1: $lirik1');
    print('Lirik 2: $lirik2');
    print('Penyanyi: $penyanyi');
  }
}