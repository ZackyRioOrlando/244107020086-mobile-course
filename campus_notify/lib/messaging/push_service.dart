import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

import '../data/notification_repository.dart';
import '../data/token_store.dart';
import '../data/api_client.dart';

final _local = FlutterLocalNotificationsPlugin();

String? pendingDeepLink;

void Function(String id)? onNotificationTap;
void Function()? onNotificationSaved;

NotificationRepository? notificationRepository;

// Channel khusus suara lonceng
const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'pengumuman_kampus_bell',
  'Pengumuman Kampus',
  description: 'Notifikasi pengumuman kampus dengan suara lonceng',
  importance: Importance.max,
  playSound: true,
  sound: RawResourceAndroidNotificationSound('bell'),
);

// Background handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  try {
    final tokenStore = TokenStore();
    final dio = buildApiClient(tokenStore);
    final repository = NotificationRepository(dio: dio);

    final notification = message.notification;

    final title =
        notification?.title ??
        message.data['title']?.toString() ??
        'Pengumuman Kampus';

    final body = notification?.body ?? message.data['body']?.toString() ?? '';

    if (body.isEmpty) return;

    await repository.saveNotification(
      title: title,
      body: body,
      data: message.data,
    );

    print('Notifikasi background berhasil disimpan');
  } catch (e) {
    print('Gagal menyimpan notifikasi background: $e');
  }
}

// Meminta izin notifikasi
Future<void> requestNotificationPermission() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

// Menyimpan notifikasi Firebase ke Laravel
Future<String?> saveFcmNotification(RemoteMessage message) async {
  final notification = message.notification;

  final title =
      notification?.title ??
      message.data['title']?.toString() ??
      'Pengumuman Kampus';

  final body = notification?.body ?? message.data['body']?.toString() ?? '';

  if (body.isEmpty) return null;

  try {
    final saved = await notificationRepository?.saveNotification(
      title: title,
      body: body,
      data: message.data,
    );

    if (saved == null) return null;

    onNotificationSaved?.call();

    return saved['id']?.toString();
  } catch (e) {
    print('Gagal menyimpan notifikasi: $e');
    return null;
  }
}

// Inisialisasi notifikasi lokal
Future<void> initLocalNotifications() async {
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');

  const ios = DarwinInitializationSettings();

  const settings = InitializationSettings(android: android, iOS: ios);

  await _local.initialize(
    settings: settings,
    onDidReceiveNotificationResponse: (response) {
      final id = response.payload;

      if (id != null && id.isNotEmpty) {
        pendingDeepLink = id;
        onNotificationTap?.call(id);
      }
    },
  );

  await _local
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(_channel);

  final details = await _local.getNotificationAppLaunchDetails();

  if (details?.didNotificationLaunchApp ?? false) {
    final id = details?.notificationResponse?.payload;

    if (id != null && id.isNotEmpty) {
      pendingDeepLink = id;
    }
  }
}

// Menampilkan notifikasi lokal dengan suara lonceng
Future<void> showLocalNotification({
  required RemoteMessage message,
  required String? payload,
}) async {
  final notification = message.notification;

  if (notification == null) return;

  await _local.show(
    id: message.hashCode,
    title: notification.title,
    body: notification.body,
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('bell'),
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
    payload: payload,
  );
}

// Inisialisasi FCM
Future<void> initFcmToken({
  required Future<void> Function(String token) onToken,
}) async {
  final token = await FirebaseMessaging.instance.getToken();

  if (token != null) {
    await onToken(token);
  }

  FirebaseMessaging.instance.onTokenRefresh.listen(onToken);

  await FirebaseMessaging.instance.subscribeToTopic('pengumuman-kampus');

  // Ketika aplikasi sedang terbuka
  FirebaseMessaging.onMessage.listen((message) async {
    final id = await saveFcmNotification(message);

    await showLocalNotification(message: message, payload: id);
  });
}
