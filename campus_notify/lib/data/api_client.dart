import 'package:dio/dio.dart';
import 'token_store.dart';

Dio buildApiClient(TokenStore store) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.18.221:8000/api',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final access = await store.readAccess();

        if (access != null) {
          options.headers['Authorization'] = 'Bearer $access';
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await store.clear();
        }

        handler.next(error);
      },
    ),
  );

  return dio;
}