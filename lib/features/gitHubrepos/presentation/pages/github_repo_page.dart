import 'package:assignmenr/features/gitHubrepos/presentation/widgets/github_repos_list.dart';
import 'package:assignmenr/features/gitHubrepos/presentation/providers/github_repos_provider.dart';
import 'package:assignmenr/utils/notifymessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GithubReposPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<GithubReposPage> createState() => _GithubReposPageState();
}

class _GithubReposPageState extends ConsumerState<GithubReposPage> {
  final ScrollController _controller = ScrollController();
  int _daysAgo = 60;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(GitHubRepoProvider.notifier)
          .getGitHubRepos(first: true, daysAgo: _daysAgo);
      //getGitHubRepos called after rendering first frame
    });

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _loadMore();
      }
    });
    //listener on scrollcontroller to detect when user reaches bottom of the page
  }

  void _loadMore() async {
    final notifier = ref.read(GitHubRepoProvider.notifier);
    if (!notifier.isLoading) {
      await notifier.getGitHubRepos(first: false, daysAgo: _daysAgo);
    }
    //loadingmore data after reaching the bottom of the page
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(GitHubRepoProvider.notifier).isLoading;
//isLoading when true method cannot be called
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
      body: GithubReposList(controller: _controller),
      //FAB to change the days Past 60 or 30 Days
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading
            ? () => NotifyUserMessage.notifyType(context, 'Loading')
            : () {
                setState(() {
                  _daysAgo = _daysAgo == 30 ? 60 : 30;
                });
                ref
                    .read(GitHubRepoProvider.notifier)
                    .getGitHubRepos(first: true, daysAgo: _daysAgo);
                //When pressed api Call will fetch data from the last 30 or 60 days
              },
        child: Text('$_daysAgo'),
      ),
    );
  }
}
