import 'dart:async';
import 'package:assignmenr/features/gitHubrepos/business/entities/gitHubRepo_entity.dart';
import 'package:assignmenr/features/gitHubrepos/business/usecases/get_gitHubRepos.dart';
import 'package:assignmenr/features/gitHubrepos/data/datasources/db_Helper.dart';
import 'package:assignmenr/features/gitHubrepos/data/datasources/gitHubrepos_remote_data_source.dart';
import 'package:assignmenr/features/gitHubrepos/data/repositories/gitHubRepos_repository_impl.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 1);
//Pagination page Provider

class GitHubRepo extends AsyncNotifier<List<GitHubRepoEntity>> {
  bool isLoading = false;

  @override
  FutureOr<List<GitHubRepoEntity>> build() {
    return [];
  }

  Future<void> getGitHubRepos(
      {required bool first, required int daysAgo}) async {
    if (isLoading) return;
    //first used to reset when user changes to past 30 days
    isLoading = state.isLoading;
    if (first) {
      state = const AsyncValue.data([]);
      state = const AsyncLoading();
      ref.read(currentPageProvider.notifier).state = 1;
    }

    try {
      final respository = ref.read(gitHubrespository);
      final currentpage = ref.read(currentPageProvider.notifier).state;

      final results = await GetRepos(gitHubRepoRepository: respository)
          .getRepos(page: currentpage, daysAgo: daysAgo);
      //calling UseCase GetRepos through which calling the respository function
      state = results.fold(
          //it returns either failure or data according to it state is changed
          (failure) => AsyncValue.error(failure, StackTrace.current), (repos) {
        ref.read(currentPageProvider.notifier).state++;
        return AsyncValue.data([...state.value!, ...repos]);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      isLoading = state.isLoading;
      //after function exection making it false
    }
  }
}

final GitHubRepoProvider =
    AsyncNotifierProvider<GitHubRepo, List<GitHubRepoEntity>>(GitHubRepo.new);
//AsyncNotifierprovider

//GitHubRepo Impl
final gitHubrespository = StateProvider((ref) {
  return GitHubRepoRepositoryImpl(
      dataSource: GitHubRepoRemoteDataSourceImpl(dbHelper: DatabaseHelper()),
      connectivity: Connectivity(),
      dbHelper: DatabaseHelper());
});
