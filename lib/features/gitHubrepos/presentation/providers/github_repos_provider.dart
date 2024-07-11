import 'dart:async';
import 'package:assignmenr/features/gitHubrepos/business/entities/gitHubRepo_entity.dart';
import 'package:assignmenr/features/gitHubrepos/business/usecases/get_gitHubRepos.dart';
import 'package:assignmenr/features/gitHubrepos/data/datasources/db_Helper.dart';
import 'package:assignmenr/features/gitHubrepos/data/datasources/gitHubrepos_remote_data_source.dart';
import 'package:assignmenr/features/gitHubrepos/data/repositories/gitHubRepos_repository_impl.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 1);

class GitHubRepo extends AsyncNotifier<List<GitHubRepoEntity>> {
  bool isLoading = false;

  @override
  FutureOr<List<GitHubRepoEntity>> build() {
    return [];
  }

  Future<void> getGitHubRepos({required bool first}) async {
    if (isLoading) return;
    isLoading = true;
    first ? state = const AsyncLoading() : null;
    try {
      final respository = ref.read(gitHubrespository);
      final currentpage = ref.read(currentPageProvider.notifier).state;

      final results = await GetRepos(gitHubRepoRepository: respository)
          .getRepos(page: currentpage);
      // state = AsyncValue.data([...?state.value, ...repos]);
      state = results.fold(
          (failure) => AsyncValue.error(failure, StackTrace.current), (repos) {
        ref.read(currentPageProvider.notifier).state++;
        return AsyncValue.data([...state.value!, ...repos]);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      isLoading = false;
    }
  }
}

final GitHubRepoProvider =
    AsyncNotifierProvider<GitHubRepo, List<GitHubRepoEntity>>(GitHubRepo.new);

final gitHubrespository = StateProvider((ref) {
  return GitHubRepoRepositoryImpl(
      dataSource: GitHubRepoRemoteDataSourceImpl(dbHelper: DatabaseHelper()),
      connectivity: Connectivity(),
      dbHelper: DatabaseHelper());
});
