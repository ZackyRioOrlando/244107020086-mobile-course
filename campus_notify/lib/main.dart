import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'providers/auth_provider.dart';
import 'providers/notification_provider.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/announcement_page.dart';

import 'messaging/push_service.dart';

final container = ProviderContainer();

class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier(ProviderContainer container) {
    _subscription = container.listen<AsyncValue<bool>>(
      authStateProvider,
      (previous, next) {
        notifyListeners();

        // Membuka halaman detail jika ada pending deep link
        final id = pendingDeepLink;

        if (next.value == true &&
            id != null &&
            id.isNotEmpty) {
          pendingDeepLink = null;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            router.go('/pengumuman/$id');
          });
        }
      },
    );
  }

  late final ProviderSubscription<AsyncValue<bool>> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

final authRouterNotifier = AuthRouterNotifier(container);

final router = GoRouter(
  refreshListenable: authRouterNotifier,
  redirect: (context, state) {
    final authState = container.read(authStateProvider);

    if (authState.isLoading) return null;

    final loggedIn = authState.value ?? false;

    final location = state.matchedLocation;

    final goingLogin = location == '/login';
    final goingRegister = location == '/register';

    if (!loggedIn && !goingLogin && !goingRegister) {
      return '/login';
    }

    if (loggedIn && (goingLogin || goingRegister)) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/pengumuman/:id',
      builder: (context, state) {
        return AnnouncementPage(
          id: state.pathParameters['id'] ?? '',
        );
      },
    ),
  ],
);

// Navigasi menuju halaman detail
void bukaPengumuman(String id) {
  if (id.isEmpty) return;

  final loggedIn =
      container.read(authStateProvider).value ?? false;

  if (loggedIn) {
    router.go('/pengumuman/$id');
  } else {
    pendingDeepLink = id;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Menghubungkan repository Laravel
  notificationRepository =
      container.read(notificationRepositoryProvider);

  // Memperbarui daftar notifikasi setelah berhasil disimpan
  onNotificationSaved = () {
    container
        .read(notificationProvider.notifier)
        .refreshNotifications();
  };

  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  await requestNotificationPermission();

  await initLocalNotifications();

  onNotificationTap = bukaPengumuman;

  await initFcmToken(
    onToken: (token) async {
      debugPrint(
        'FCM Token: ${token.substring(0, 12)}...',
      );
    },
  );

  // Jika aplikasi dibuka melalui notifikasi Firebase
  final initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    final id = await saveFcmNotification(initialMessage);

    if (id != null) {
      pendingDeepLink = id;
    }
  }

  // Jika notifikasi Firebase ditekan saat aplikasi background
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) async {
      final id = await saveFcmNotification(message);

      if (id != null) {
        bukaPengumuman(id);
      }
    },
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}