import 'package:dio/dio.dart';

class AuthSession {
  const AuthSession({
    required this.access,
    required this.user,
  });

  final String access;
  final Map<String, dynamic> user;
}

class AuthRepository {
  AuthRepository({required this.dio});

  final Dio dio;

  // Register akun baru
  Future<AuthSession> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      return AuthSession(
        access: response.data['token'],
        user: Map<String, dynamic>.from(response.data['user']),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? 'Registrasi gagal',
      );
    }
  }

  // Login akun
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthSession(
        access: response.data['token'],
        user: Map<String, dynamic>.from(response.data['user']),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? 'Login gagal',
      );
    }
  }

  // Logout akun
  Future<void> logout() async {
    try {
      await dio.post('/logout');
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? 'Logout gagal',
      );
    }
  }
}