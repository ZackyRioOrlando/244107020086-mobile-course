import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/token_store.dart';
import '../data/auth_repository.dart';
import '../data/api_client.dart';

// Penyimpanan token
final tokenStoreProvider = Provider<TokenStore>((ref) {
  return TokenStore();
});

// API Client
final apiClientProvider = Provider((ref) {
  final store = ref.watch(tokenStoreProvider);
  return buildApiClient(store);
});

// Auth Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(apiClientProvider);
  return AuthRepository(dio: dio);
});

// Status autentikasi
final authStateProvider =
    AsyncNotifierProvider<AuthNotifier, bool>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final token = await ref.watch(tokenStoreProvider).readAccess();
    return token != null;
  }

  // Login
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final session = await ref
          .read(authRepositoryProvider)
          .login(email: email, password: password);

      await ref.read(tokenStoreProvider).save(
            access: session.access,
          );

      return true;
    });
  }

  // Register
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final session = await ref.read(authRepositoryProvider).register(
            name: name,
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation,
          );

      await ref.read(tokenStoreProvider).save(
            access: session.access,
          );

      return true;
    });
  }

  // Logout
  Future<void> logout() async {
    try {
      await ref.read(authRepositoryProvider).logout();
    } finally {
      await ref.read(tokenStoreProvider).clear();
      state = const AsyncData(false);
    }
  }
}