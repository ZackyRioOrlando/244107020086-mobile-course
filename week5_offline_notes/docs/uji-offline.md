# Uji Offline-First

1. Isi cache
   Saat kondisi online dan halaman Posts dibuka, 100 posts berhasil ditampilkan dan data tersimpan ke dalam cache `cached_posts`.

2. Cache saat offline
   Setelah mode pesawat diaktifkan, aplikasi ditutup dan dibuka kembali. Halaman Posts tetap dapat menampilkan data dari cache tanpa error.

3. Antrean dirty
   Dalam kondisi offline, 3 catatan berhasil ditambahkan dan badge menunjukkan angka 3 sebagai tanda bahwa terdapat 3 catatan yang belum tersinkron.

4. Sync ditolak
   Setelah mengaktifkan Paksa mode offline dan menekan tombol Sinkronkan, muncul Snackbar “Perangkat offline…” dan badge tetap menunjukkan angka 3.

5. Sync berhasil
   Setelah Paksa mode offline dimatikan dan tombol Sinkronkan ditekan, proses berjalan sekitar 1 detik. Muncul pesan bahwa 3 catatan berhasil disinkronkan, badge menghilang, dan ikon berubah menjadi awan hijau.

6. Refresh background
   Saat kembali online dan membuka halaman Posts, data langsung tampil dari cache kemudian diperbarui kembali di latar belakang.

Kesimpulan:
Berdasarkan pengujian, seluruh skenario offline-first berjalan dengan normal. Aplikasi tetap dapat menampilkan data dari cache saat offline dan dapat melakukan sinkronisasi kembali ketika perangkat online.
