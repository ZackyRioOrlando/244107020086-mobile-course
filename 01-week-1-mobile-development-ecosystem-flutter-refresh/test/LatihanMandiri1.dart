double hitungLuasPersegiPanjang(double panjang, double lebar) {
  return panjang * lebar;
}

void main() {
  double panjang = 5;
  double lebar = 3;

  double luas = hitungLuasPersegiPanjang(panjang, lebar);

  print("Luas Persegi Panjang ini adalah $luas");
}