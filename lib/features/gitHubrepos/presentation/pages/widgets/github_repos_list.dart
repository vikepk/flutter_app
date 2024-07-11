import 'package:assignmenr/features/gitHubrepos/presentation/providers/github_repos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'github_repo_item.dart';

class GithubReposList extends ConsumerWidget {
  final ScrollController controller;

  GithubReposList({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reposAsyncValue = ref.watch(GitHubRepoProvider);

    return reposAsyncValue.when(
      data: (repos) => ListView.builder(
        controller: controller,
        itemCount: repos.length + 1,
        itemBuilder: (context, index) {
          if (repos.isEmpty) {
            return const Center(
                child: Text(
              'No repositories found.',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ));
          } else if (index == repos.length) {
            return SizedBox(
                height: 200,
                child: Column(
                  children: [
                    _buildLoadingShimmer(),
                    _buildLoadingShimmer(),
                  ],
                ));
          } else {
            final repo = repos[index];
            return GithubRepoItem(repo: repo);
          }
        },
      ),
      loading: () => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildLoadingShimmer();
        },
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

Widget _buildLoadingShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
      ),
      title: Container(
        width: double.infinity,
        height: 10.0,
        color: Colors.grey,
      ),
      subtitle: Container(
        width: double.infinity,
        height: 10.0,
        color: Colors.grey,
      ),
      trailing: Container(
        width: 30.0,
        height: 10.0,
        color: Colors.grey,
      ),
    ),
  );
}
