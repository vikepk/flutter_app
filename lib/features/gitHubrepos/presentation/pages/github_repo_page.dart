import 'package:assignmenr/features/gitHubrepos/presentation/pages/widgets/github_repos_list.dart';
import 'package:assignmenr/features/gitHubrepos/presentation/providers/github_repos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GithubReposPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<GithubReposPage> createState() => _GithubReposPageState();
}

class _GithubReposPageState extends ConsumerState<GithubReposPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(GitHubRepoProvider.notifier).getGitHubRepos(first: true);
    });

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _loadMore();
      }
    });
  }

  void _loadMore() async {
    final notifier = ref.read(GitHubRepoProvider.notifier);
    if (!notifier.isLoading) {
      await notifier.getGitHubRepos(first: false);
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1B1B1B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B1B1B),
          title: const Text('GitHub Repos'),
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        body: GithubReposList(controller: _controller));
  }
}
