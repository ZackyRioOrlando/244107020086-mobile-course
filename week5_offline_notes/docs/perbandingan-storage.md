# Perbandingan Storage Offline Notes

| Kriteria | SharedPreferences | Hive | sqflite (SQLite) | Drift |
|---|---|---|---|---|
| Kompleksitas query | Rendah | Rendah–Sedang | Tinggi | Tinggi |
| Dukungan relasi | Tidak cocok | Terbatas | Baik | Baik |
| Reaktivitas (stream) | Tidak utama | Ada | Tidak bawaan | Sangat baik |
| Type-safety | Rendah | Sedang | Rendah | Tinggi |
| Ukuran boilerplate | Sangat kecil | Kecil | Sedang | Sedang–Tinggi |
| Kemudahan testing | Mudah | Mudah–Sedang | Sedang | Baik |
| Cocok untuk preferensi? | Sangat cocok | Cocok | Kurang cocok | Berlebihan |
| Cocok untuk 1000+ catatan? | Tidak cocok | Cocok | Sangat cocok | Sangat cocok |
| Keputusan | Dipilih | Tidak dipilih | Dipilih | Tidak dipilih |

Tambahan pada baris keputusan:
SharedPreferences: Dipilih karena sederhana untuk data kecil seperti tema
Hive: Tidak dipilih karena kebutuhan catatan lebih membutuhkan query dan struktur database yang fleksibel
sqflite: Dipilih karena mendukung SQLite, query, dan data banyak
Drift: Tidak dipilih karena lebih kompleks


AI Verification Checklist
- Apakah AI menempatkan daftar catatan di SharedPreferences? (Tolak: rapuh untuk koleksi.)
Jawaban:
AI tidak merekomendasikan SharedPreferences untuk menyimpan daftar catatan karena kurang cocok untuk koleksi data yang banyak.

- Apakah skema AI mendukung antrean sync (dirty flag / updated_at) atau hanya CRUD
polos?
Jawaban:
Untuk catatan digunakan dirty dan updated_at sehingga data yang belum tersinkron dapat diketahui.

- Apakah klaim “real-time” AI didukung stream (Drift watch) atau hanya asumsi?
Jawaban:
Kemampuan stream lebih jelas pada Drift karena menyediakan mekanisme watch. Jadi klaim real-time tidak boleh hanya berdasarkan asumsi.

- Apakah estimasi boilerplate AI masuk akal setelah Anda mencoba instalasinya (flutter pub
add + migrasi skema)?
Jawaban:
SharedPreferences memiliki boilerplate paling sedikit, sedangkan SQLite dan Drift membutuhkan struktur database yang lebih banyak.

- Keputusan final Anda beserta alasannya — boleh berbeda dari rekomendasi AI selama
berargumen.
Jawaban:
Saya memilih SharedPreferences untuk preferensi tema dan SQLite/sqflite untuk catatan karena preferensi hanya berupa data sederhana, sedangkan catatan membutuhkan penyimpanan banyak data, query, serta penanda sinkronisasi.