import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../providers/notification_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                  .read(notificationProvider.notifier)
                  .refreshNotifications();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref
                  .read(authStateProvider.notifier)
                  .logout();
            },
          ),
        ],
      ),
      body: notifications.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Terjadi kesalahan: $error'),
          );
        },
        data: (daftarNotifikasi) {
          if (daftarNotifikasi.isEmpty) {
            return const Center(
              child: Text('Belum ada pengumuman.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return ref
                  .read(notificationProvider.notifier)
                  .refreshNotifications();
            },
            child: ListView.builder(
              itemCount: daftarNotifikasi.length,
              itemBuilder: (context, index) {
                final notifikasi = daftarNotifikasi[index];

                final id = notifikasi['id'].toString();
                final title =
                    notifikasi['title'] ?? 'Tanpa Judul';
                final body =
                    notifikasi['body'] ?? '';

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.notifications),
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      context.go('/pengumuman/$id');
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
