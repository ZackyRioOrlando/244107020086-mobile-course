import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/notification_repository.dart';
import 'auth_provider.dart';

final notificationRepositoryProvider =
    Provider<NotificationRepository>((ref) {
  final dio = ref.watch(apiClientProvider);
  return NotificationRepository(dio: dio);
});

final notificationProvider = AsyncNotifierProvider<
    NotificationNotifier,
    List<Map<String, dynamic>>>(
  NotificationNotifier.new,
);

class NotificationNotifier
    extends AsyncNotifier<List<Map<String, dynamic>>> {

  @override
  Future<List<Map<String, dynamic>>> build() async {
    return ref
        .read(notificationRepositoryProvider)
        .getNotifications();
  }

  // Memperbarui daftar notifikasi
  Future<void> refreshNotifications() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      return ref
          .read(notificationRepositoryProvider)
          .getNotifications();
    });
  }

  // Mengambil detail notifikasi
  Future<Map<String, dynamic>> getNotificationDetail(int id) {
    return ref
        .read(notificationRepositoryProvider)
        .getNotificationDetail(id);
  }

  // Menandai notifikasi sudah dibaca
  Future<void> markAsRead(int id) async {
    await ref
        .read(notificationRepositoryProvider)
        .markAsRead(id);

    await refreshNotifications();
  }
}