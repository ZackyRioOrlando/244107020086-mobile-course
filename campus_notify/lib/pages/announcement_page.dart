import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/notification_provider.dart';

class AnnouncementPage extends ConsumerStatefulWidget {
  final String id;

  const AnnouncementPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<AnnouncementPage> createState() =>
      _AnnouncementPageState();
}

class _AnnouncementPageState
    extends ConsumerState<AnnouncementPage> {
  late Future<Map<String, dynamic>> detailPengumuman;

  @override
  void initState() {
    super.initState();
    detailPengumuman = muatDetailPengumuman();
  }

  Future<Map<String, dynamic>> muatDetailPengumuman() async {
    final id = int.parse(widget.id);

    final repository =
        ref.read(notificationRepositoryProvider);

    // Mengambil detail dari Laravel
    final detail =
        await repository.getNotificationDetail(id);

    // Menandai notifikasi sudah dibaca
    await repository.markAsRead(id);

    // Memperbarui daftar notifikasi
    await ref
        .read(notificationProvider.notifier)
        .refreshNotifications();

    return detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: detailPengumuman,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Gagal memuat detail pengumuman.',
              ),
            );
          }

          final pengumuman = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pengumuman['title'] ?? 'Tanpa Judul',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  pengumuman['body'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}