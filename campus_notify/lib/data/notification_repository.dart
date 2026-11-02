import 'package:dio/dio.dart';

class NotificationRepository {
  final Dio dio;

  NotificationRepository({required this.dio});

  // Mengambil daftar notifikasi yang belum dibaca
  Future<List<Map<String, dynamic>>> getNotifications() async {
    final response = await dio.get('/notifications');

    final List<dynamic> data =
        response.data['notifications'] ?? [];

    return data
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  // Menyimpan notifikasi dari Firebase
  Future<Map<String, dynamic>> saveNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    final response = await dio.post(
      '/notifications',
      data: {
        'title': title,
        'body': body,
        'data': data ?? {},
      },
    );

    return Map<String, dynamic>.from(
      response.data['notification'],
    );
  }

  // Mengambil detail notifikasi berdasarkan ID Laravel
  Future<Map<String, dynamic>> getNotificationDetail(int id) async {
    final response = await dio.get('/notifications/$id');

    return Map<String, dynamic>.from(
      response.data['notification'],
    );
  }

  // Menandai notifikasi sebagai sudah dibaca
  Future<void> markAsRead(int id) async {
    await dio.post('/notifications/$id/read');
  }
}