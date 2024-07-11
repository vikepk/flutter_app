import 'package:assignmenr/features/gitHubrepos/presentation/pages/gitHubrepo_detailspage.dart';
import 'package:assignmenr/features/gitHubrepos/presentation/pages/github_repo_page.dart';
import 'package:assignmenr/features/tasks/pages/main_task_page.dart';
import 'package:assignmenr/features/tasks/pages/task_detail_page.dart';
import 'package:assignmenr/main.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/repos',
      builder: (context, state) => GithubReposPage(),
    ),
    GoRoute(
        path: '/repodetail',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return GitHubRepoDetailPage(repo: extra['repo']);
        }),
    GoRoute(
      path: '/task',
      builder: (context, state) => const MainTaskPage(),
    ),
    GoRoute(
        path: '/taskdetail',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return TaskDetailPage(task: extra['task']);
        }),
  ],
);
