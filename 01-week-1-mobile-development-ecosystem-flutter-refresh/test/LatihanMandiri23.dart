class Profil {
  String nama;
  String nim;
  String? email;

  Profil(this.nama, this.nim, this.email);
}

void main() {
  Profil profil = Profil("Zacky Rio Orlando", "244107020086", null);

  print("Profil Mahasiswa");
  print("Nama: ${profil.nama}");
  print("NIM: ${profil.nim}");
  print("Email: ${profil.email ?? "Email belum diisi"}");
}