import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'liriklagu.dart';
import 'daftarwidget.dart';

// ======================================================
// TEMA GLOBAL (light / dark)
// ======================================================

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() => runApp(const MyApp());

// ======================================================
// ROUTER
// ======================================================

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Zacky()),
    GoRoute(
      path: '/daftar-widget',
      builder: (context, state) => const DaftarWidget(),
    ),
  ],
);

// ======================================================
// MY APP
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color.fromARGB(255, 76, 0, 208);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp.router(
          title: 'Lirik Lagu',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: seed),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: seed,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          routerConfig: router,
        );
      },
    );
  }
}

// ======================================================
// DATA LAGU
// ======================================================

class Track {
  final Liriklagu lagu;
  int durasi; // detik (diperbarui otomatis dari file mp3)
  final Color warna;
  final String audio; // path di dalam folder assets/, mis. 'audio/js.mp3'
  Track(this.lagu, this.durasi, this.warna, this.audio);
}

// Ganti isi lirik sesuai kebutuhanmu.
final List<Track> daftarTrack = [
  Track(
    Liriklagu(
      judul: 'Janji Setia',
      lirik1: 'Langkah kecil di pagi hari,\nmenyapa mimpi yang belum usai.',
      lirik2: 'Kita tulis satu per satu,\nbaris kode jadi cerita.',
      penyanyi: 'Tiara Andini',
    ),
    0,
    Colors.deepPurple,
    'audio/Tiara_Andini_Janji_Setia.mp3',
  ),
  Track(
    Liriklagu(
      judul: 'Senja di Malang',
      lirik1: 'Lampu kota mulai menyala,\nangin dingin membawa tenang.',
      lirik2: 'Di bangku taman kita duduk,\nmenunggu malam datang perlahan.',
      penyanyi: 'Ryoo',
    ),
    0,
    Colors.deepOrange,
    'audio/senja-di-malang.mp3',
  ),
  Track(
    Liriklagu(
      judul: 'Debug Malam',
      lirik1: 'Error merah di layar gelap,\nkopi dingin di samping tangan.',
      lirik2: 'Sekali lagi kucoba jalan,\nhingga hijau semua terlihat.',
      penyanyi: 'Flutter Band',
    ),
    0,
    Colors.teal,
    'audio/debug-malam.mp3',
  ),
  Track(
    Liriklagu(
      judul: 'Widget Tree',
      lirik1: 'Akar berpijak pada satu induk,\ncabang tumbuh ke segala arah.',
      lirik2: 'Setiap daun adalah bagian,\nsetiap state membawa cerita.',
      penyanyi: 'Stateful',
    ),
    0,
    Colors.pink,
    'audio/widget-tree.mp3',
  ),
];

// ======================================================
// ZACKY - STATEFUL WIDGET
// ======================================================

class Zacky extends StatefulWidget {
  const Zacky({super.key});

  @override
  State<Zacky> createState() => _ZackyState();
}

class _ZackyState extends State<Zacky> with SingleTickerProviderStateMixin {
  // ---------------- STATE ----------------
  int current = 0;
  int position = 0; // detik
  bool isPlaying = false;
  bool shuffle = false;
  bool repeat = false;
  bool favOnly = false;
  double volume = 0.7;
  double lyricSize = 16;
  String query = '';

  final Set<int> favorites = {};
  final TextEditingController searchController = TextEditingController();
  final Random _rand = Random();

  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<Duration>? _durSub;
  StreamSubscription<void>? _endSub;
  StreamSubscription<String>? _logSub;
  bool _dragging = false;
  int _loadedIndex = -1;
  bool isLoading = false;
  String? error;
  late final AnimationController _disc = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );

  Track get track => daftarTrack[current];
  bool get isFavorite => favorites.contains(current);

  // ---------------- HELPER ----------------
  String fmt(int s) => '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';

  void _msg(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  List<int> get visible {
    final q = query.toLowerCase();
    return [
      for (var i = 0; i < daftarTrack.length; i++)
        if ((!favOnly || favorites.contains(i)) &&
            (daftarTrack[i].lagu.judul.toLowerCase().contains(q) ||
                daftarTrack[i].lagu.penyanyi.toLowerCase().contains(q)))
          i,
    ];
  }

  // ---------------- PLAYER (AUDIO ASLI) ----------------
  // Baris lirik yang aktif berganti di setengah durasi lagu.
  double get _half => track.durasi > 0 ? _half : double.infinity;

  @override
  void initState() {
    super.initState();
    _player.setVolume(volume);
    _player.setReleaseMode(ReleaseMode.stop);

    _posSub = _player.onPositionChanged.listen((d) {
      if (!mounted || _dragging) return;
      if (d.inSeconds != position) setState(() => position = d.inSeconds);
    });

    _durSub = _player.onDurationChanged.listen((d) {
      if (!mounted || d.inSeconds == 0) return;
      setState(() => track.durasi = d.inSeconds);
    });

    _endSub = _player.onPlayerComplete.listen((_) {
      if (mounted) nextSong();
    });

    _logSub = _player.onLog.listen((m) {
      if (mounted) setState(() => error = m);
    });

    // Muat lagu pertama supaya durasi asli langsung tampil.
    _loadSource();
  }

  /// Memuat file mp3 lagu saat ini (belum diputar) dan membaca durasinya.
  Future<void> _loadSource() async {
    final idx = current;
    final t = daftarTrack[idx];
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      await _player.setSource(AssetSource(t.audio));
      _loadedIndex = idx;
      final d = await _player.getDuration();
      if (mounted && d != null && d.inSeconds > 0) {
        setState(() => t.durasi = d.inSeconds);
      }
    } catch (e) {
      _loadedIndex = -1;
      if (mounted && idx == current) {
        setState(() => error = 'Tidak bisa memuat "${t.audio}": $e');
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _resume() async {
    try {
      if (_loadedIndex != current) await _loadSource();
      if (error != null) return;
      await _player.resume();
      if (!mounted) return;
      setState(() => isPlaying = true);
      _disc.repeat();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isPlaying = false;
        error = 'Gagal memutar: $e';
      });
      _disc.stop();
    }
  }

  Future<void> togglePlay() async {
    if (isLoading) return;
    if (isPlaying) {
      await _player.pause();
      if (!mounted) return;
      setState(() => isPlaying = false);
      _disc.stop();
    } else {
      await _resume();
    }
  }

  Future<void> _goTo(int i, {bool? autoplay}) async {
    final play = autoplay ?? isPlaying;
    try {
      await _player.stop();
    } catch (_) {}
    setState(() {
      current = i;
      position = 0;
      isPlaying = false;
    });
    _disc.stop();
    await _loadSource();
    if (play) await _resume();
  }

  Future<void> selectSong(int i) async {
    if (i == current) {
      if (!isPlaying) await togglePlay();
      return;
    }
    await _goTo(i, autoplay: true);
  }

  void nextSong() {
    int next;
    if (shuffle && daftarTrack.length > 1) {
      do {
        next = _rand.nextInt(daftarTrack.length);
      } while (next == current);
    } else {
      next = (current + 1) % daftarTrack.length;
    }
    _goTo(next, autoplay: true);
  }

  void previousSong() {
    if (position > 3) {
      setState(() => position = 0);
      _seek(0);
    } else {
      _goTo((current - 1 + daftarTrack.length) % daftarTrack.length);
    }
  }

  Future<void> _seek(int detik) async {
    if (_loadedIndex != current) return;
    try {
      await _player.seek(Duration(seconds: detik));
    } catch (_) {}
  }

  void _skip(int delta) {
    final np = (position + delta).clamp(0, track.durasi).toInt();
    setState(() => position = np);
    _seek(np);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite ? favorites.remove(current) : favorites.add(current);
    });
    _msg(isFavorite ? 'Ditambahkan ke favorit' : 'Dihapus dari favorit');
  }

  void copyLyrics() {
    Clipboard.setData(
      ClipboardData(text: '${track.lagu.lirik1}\n\n${track.lagu.lirik2}'),
    );
    _msg('Lirik disalin ke clipboard');
  }

  void toggleTheme() {
    themeNotifier.value = themeNotifier.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    setState(() {});
  }

  @override
  void dispose() {
    _posSub?.cancel();
    _durSub?.cancel();
    _endSub?.cancel();
    _logSub?.cancel();
    _player.dispose();
    _disc.dispose();
    searchController.dispose();
    super.dispose();
  }

  // ====================================================
  // BUILD
  // ====================================================

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('${track.lagu.judul} by ${track.lagu.penyanyi}'),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      drawer: _buildDrawer(cs, isDark),
      body: LayoutBuilder(
        builder: (context, box) {
          final wide = box.maxWidth >= 900;

          if (wide) {
            // ===== LAYOUT LEBAR: 2 KOLOM, ISI PENUH =====
            return Row(
              children: [
                // Kolom kiri: piringan + judul
                Expanded(
                  flex: 5,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [track.warna.withAlpha(70), Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildDisc(
                              cs,
                              size: min(340.0, max(200.0, box.maxHeight * 0.6)),
                            ),
                            const SizedBox(height: 20),
                            _buildTitle(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Kolom kanan: cari, daftar lagu, lirik, pengaturan
                Expanded(
                  flex: 6,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 28, 40, 28),
                    children: [
                      _buildSearch(cs),
                      const SizedBox(height: 12),
                      _buildFilters(),
                      const SizedBox(height: 16),
                      _buildCarousel(cs, wrap: true),
                      const SizedBox(height: 28),
                      _buildLyricsHeader(),
                      const SizedBox(height: 12),
                      _lyricCard(track.lagu.lirik1, position < _half, cs),
                      const SizedBox(height: 12),
                      _lyricCard(track.lagu.lirik2, position >= _half, cs),
                      const SizedBox(height: 20),
                      _buildSettings(cs),
                    ],
                  ),
                ),
              ],
            );
          }

          // ===== LAYOUT SEMPIT (HP): 1 KOLOM, LEBAR PENUH =====
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSearch(cs),
              const SizedBox(height: 12),
              _buildFilters(),
              const SizedBox(height: 12),
              _buildCarousel(cs),
              const SizedBox(height: 24),
              _buildDisc(cs),
              const SizedBox(height: 16),
              _buildTitle(),
              const SizedBox(height: 20),
              _buildLyricsHeader(),
              const SizedBox(height: 12),
              _lyricCard(track.lagu.lirik1, position < _half, cs),
              const SizedBox(height: 12),
              _lyricCard(track.lagu.lirik2, position >= _half, cs),
              const SizedBox(height: 20),
              _buildSettings(cs),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildPlayerBar(cs),
    );
  }

  // ---------------- DRAWER ----------------
  Widget _buildDrawer(ColorScheme cs, bool isDark) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primary, cs.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Daftar Lagu',
                style: TextStyle(color: cs.onPrimary, fontSize: 26),
              ),
            ),
          ),
          for (var i = 0; i < daftarTrack.length; i++)
            ListTile(
              leading: Icon(
                i == current && isPlaying ? Icons.equalizer : Icons.music_note,
                color: daftarTrack[i].warna,
              ),
              title: Text(daftarTrack[i].lagu.judul),
              subtitle: Text(daftarTrack[i].lagu.penyanyi),
              selected: i == current,
              onTap: () {
                Navigator.pop(context);
                selectSong(i);
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.widgets),
            title: const Text('Daftar Widget'),
            onTap: () {
              Navigator.pop(context);
              context.go('/daftar-widget');
            },
          ),
          SwitchListTile(
            title: const Text('Mode Gelap'),
            secondary: const Icon(Icons.dark_mode),
            value: isDark,
            onChanged: (_) => toggleTheme(),
          ),
        ],
      ),
    );
  }

  // ---------------- SEARCH ----------------
  Widget _buildSearch(ColorScheme cs) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Cari judul atau penyanyi...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: query.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  searchController.clear();
                  setState(() => query = '');
                },
              ),
        filled: true,
        fillColor: cs.onSurface.withAlpha(25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (v) => setState(() => query = v),
    );
  }

  // ---------------- FILTER CHIP ----------------
  Widget _buildFilters() {
    return Row(
      children: [
        ChoiceChip(
          label: Text('Semua (${daftarTrack.length})'),
          selected: !favOnly,
          onSelected: (_) => setState(() => favOnly = false),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          avatar: const Icon(Icons.favorite, size: 16),
          label: Text('Favorit (${favorites.length})'),
          selected: favOnly,
          onSelected: (_) => setState(() => favOnly = true),
        ),
      ],
    );
  }

  // ---------------- DAFTAR LAGU ----------------
  Widget _buildCarousel(ColorScheme cs, {bool wrap = false}) {
    final items = visible;
    if (items.isEmpty) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: Text(
          favOnly ? 'Belum ada lagu favorit' : 'Lagu tidak ditemukan',
          style: TextStyle(color: cs.outline),
        ),
      );
    }
    if (wrap) {
      return Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [for (final i in items) _songCard(i, cs, 170, 120)],
      );
    }
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, idx) => _songCard(items[idx], cs, 140, 110),
      ),
    );
  }

  Widget _songCard(int i, ColorScheme cs, double w, double h) {
    final t = daftarTrack[i];
    final selected = i == current;
    return GestureDetector(
      onTap: () => selectSong(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: w,
        height: h,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [t.warna, t.warna.withAlpha(140)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: selected ? cs.onSurface : Colors.transparent,
            width: 2,
          ),
          boxShadow: selected
              ? [BoxShadow(color: t.warna.withAlpha(120), blurRadius: 12)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              selected && isPlaying ? Icons.equalizer : Icons.music_note,
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.lagu.judul,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  t.lagu.penyanyi,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- COVER (PIRINGAN BERPUTAR) ----------------
  Widget _buildDisc(ColorScheme cs, {double size = 230}) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: _disc,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    track.warna,
                    Colors.black87,
                    track.warna,
                    Colors.black87,
                    track.warna,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: track.warna.withAlpha(isPlaying ? 140 : 60),
                    blurRadius: isPlaying ? 30 : 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: CircleAvatar(
                  radius: size * 0.24,
                  backgroundColor: cs.surface,
                  child: Icon(
                    Icons.music_note,
                    size: size * 0.21,
                    color: track.warna,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              backgroundColor: cs.onSurface.withAlpha(25),
              child: IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (c, a) =>
                      ScaleTransition(scale: a, child: c),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isFavorite),
                    color: Colors.red,
                  ),
                ),
                onPressed: toggleFavorite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- JUDUL ----------------
  Widget _buildTitle() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Column(
        key: ValueKey(current),
        children: [
          Text(
            track.lagu.judul,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            track.lagu.penyanyi,
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LIRIK ----------------
  Widget _buildLyricsHeader() {
    return Row(
      children: [
        Icon(Icons.lyrics, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        const Text(
          'Lirik Lagu',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Salin lirik',
          icon: const Icon(Icons.copy),
          onPressed: copyLyrics,
        ),
      ],
    );
  }

  Widget _lyricCard(String text, bool active, ColorScheme cs) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: active ? cs.primaryContainer : cs.onSurface.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: active ? cs.primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 400),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          height: 1.8,
          fontSize: lyricSize,
          color: active ? cs.onPrimaryContainer : cs.onSurfaceVariant,
        ),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }

  // ---------------- PENGATURAN ----------------
  Widget _buildSettings(ColorScheme cs) {
    return Card(
      elevation: 0,
      color: cs.onSurface.withAlpha(25),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(volume == 0 ? Icons.volume_off : Icons.volume_up),
                  onPressed: () {
                    setState(() => volume = volume == 0 ? 0.7 : 0);
                    _player.setVolume(volume);
                  },
                ),
                Expanded(
                  child: Slider(
                    value: volume,
                    onChanged: (v) {
                      setState(() => volume = v);
                      _player.setVolume(v);
                    },
                  ),
                ),
                Text('${(volume * 100).round()}%'),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.format_size),
                ),
                Expanded(
                  child: Slider(
                    value: lyricSize,
                    min: 12,
                    max: 28,
                    divisions: 8,
                    label: '${lyricSize.round()}',
                    onChanged: (v) => setState(() => lyricSize = v),
                  ),
                ),
                Text('${lyricSize.round()}pt'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- PEMUTAR DI BAWAH ----------------
  Widget _buildPlayerBar(ColorScheme cs) {
    final total = max(1, track.durasi);
    return Material(
      elevation: 12,
      color: cs.surface,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (error != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, size: 16, color: cs.error),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        error!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: cs.error, fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: _loadSource,
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(fmt(position), style: const TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      value: position.clamp(0, total).toDouble(),
                      max: total.toDouble(),
                      onChangeStart: (_) => _dragging = true,
                      onChanged: (v) => setState(() => position = v.round()),
                      onChangeEnd: (v) async {
                        _dragging = false;
                        await _seek(v.round());
                      },
                    ),
                  ),
                  Text(fmt(track.durasi), style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: LayoutBuilder(
                builder: (context, box) {
                  final showInfo = box.maxWidth >= 600;
                  return Row(
                    children: [
                      // ---- KIRI: info lagu ----
                      Expanded(
                        child: showInfo
                            ? Row(
                                children: [
                                  Icon(Icons.music_note, color: track.warna),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      track.lagu.judul,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),

                      // ---- TENGAH: tombol kontrol ----
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Acak',
                            icon: Icon(
                              Icons.shuffle,
                              color: shuffle ? cs.primary : cs.outline,
                            ),
                            onPressed: () {
                              setState(() => shuffle = !shuffle);
                              _msg(shuffle ? 'Acak aktif' : 'Acak nonaktif');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_previous),
                            onPressed: previousSong,
                          ),
                          if (showInfo)
                            IconButton(
                              tooltip: 'Mundur 10 detik',
                              icon: const Icon(Icons.replay_10),
                              onPressed: () => _skip(-10),
                            ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(12),
                            ),
                            onPressed: togglePlay,
                            child: isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: cs.onPrimary,
                                    ),
                                  )
                                : Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                  ),
                          ),
                          if (showInfo)
                            IconButton(
                              tooltip: 'Maju 10 detik',
                              icon: const Icon(Icons.forward_10),
                              onPressed: () => _skip(10),
                            ),
                          IconButton(
                            icon: const Icon(Icons.skip_next),
                            onPressed: nextSong,
                          ),
                          IconButton(
                            tooltip: 'Ulangi',
                            icon: Icon(
                              repeat ? Icons.repeat_one : Icons.repeat,
                              color: repeat ? cs.primary : cs.outline,
                            ),
                            onPressed: () {
                              setState(() => repeat = !repeat);
                              _player.setReleaseMode(
                                repeat ? ReleaseMode.loop : ReleaseMode.stop,
                              );
                              _msg(
                                repeat
                                    ? 'Ulangi lagu aktif'
                                    : 'Ulangi nonaktif',
                              );
                            },
                          ),
                        ],
                      ),

                      // ---- KANAN: favorit ----
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: showInfo
                              ? IconButton(
                                  tooltip: 'Favorit',
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: toggleFavorite,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
