import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/post.dart';
import 'providers.dart';

class PagedPostsState {
  const PagedPostsState({
    this.items = const [],
    this.page = 0,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });

  final List<Post> items;
  final int page;
  final bool isLoadingMore;
  final bool hasMore;
  final Object? error;
}

class PagedPostsNotifier extends Notifier<PagedPostsState> {
  @override
  PagedPostsState build() {
    return const PagedPostsState();
  }

  Future<void> loadNextPage() async {
    if (state.isLoadingMore || !state.hasMore) return;

    final repo = ref.read(postRepositoryProvider);
    final currentItems = state.items;
    final currentPage = state.page;

    state = PagedPostsState(
      items: currentItems,
      page: currentPage,
      isLoadingMore: true,
      hasMore: state.hasMore,
    );

    try {
      final next = currentPage + 1;
      final items = await repo.fetchPostsPage(page: next, limit: 10);

      state = PagedPostsState(
        items: [...currentItems, ...items],
        page: next,
        isLoadingMore: false,
        hasMore: items.isNotEmpty,
      );
    } catch (e) {
      state = PagedPostsState(
        items: currentItems,
        page: currentPage,
        isLoadingMore: false,
        hasMore: state.hasMore,
        error: e,
      );
    }
  }
}