import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:week4_api/data/models/post.dart';
import 'package:week4_api/data/repositories/post_repository.dart';
import 'package:week4_api/data/providers.dart';

class FakePostRepository extends PostRepository {
  FakePostRepository({this.items, this.throwError = false}) : super(Dio());

  final List<Post>? items;
  final bool throwError;

  @override
  Future<List<Post>> fetchPosts() async {
    if (throwError) {
      throw DioException(
        requestOptions: RequestOptions(path: '/posts'),
        type: DioExceptionType.connectionError,
      );
    }
    return items ?? const [];
  }
}

void main() {
  group('Unit Test Post & Provider', () {
    test('fromJson aman terhadap field yang hilang', () {
      final json = {'id': 1, 'title': 'Test Title'};
      final post = Post.fromJson(json);

      expect(post.id, 1);
      expect(post.title, 'Test Title');
      expect(post.body, '');
    });

    test('friendlyErrorMessage untuk connection error', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/posts'),
        type: DioExceptionType.connectionError,
      );

      expect(exception.type, DioExceptionType.connectionError);
    });

    test('Provider sukses dengan repository palsu', () async {
      final fakePosts = [
        const Post(userId: 1, id: 1, title: 'Post 1', body: 'Body 1'),
      ];

      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(
            FakePostRepository(items: fakePosts),
          ),
        ],
      );
      addTearDown(container.dispose);

      final posts = await container.read(postListProvider.future);
      expect(posts.length, 1);
      expect(posts[0].title, 'Post 1');
    });

    test('Provider error dengan repository palsu', () async {
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(
            FakePostRepository(throwError: true),
          ),
        ],
      );
      addTearDown(container.dispose);
      expect(
        () => container.read(postListProvider.future),
        throwsA(isA<DioException>()),
      );
    });

    test('Provider sukses dengan list kosong (empty state)', () async {
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(
            FakePostRepository(items: []),
          ),
        ],
      );
      addTearDown(container.dispose);

      final posts = await container.read(postListProvider.future);
      expect(posts, isEmpty);
    });
  });
}
