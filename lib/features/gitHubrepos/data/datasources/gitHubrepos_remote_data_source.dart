import 'dart:convert';

import 'package:assignmenr/features/gitHubrepos/data/datasources/db_Helper.dart';

import '../../../../../core/errors/exceptions.dart';
import '../models/gitHubRepo_model.dart';
import 'package:http/http.dart' as http;

abstract class GitHubRepoRemoteDataSource {
  Future<List<GitHubRepoModel>> getGitHubRepos({required int page});
}

class GitHubRepoRemoteDataSourceImpl implements GitHubRepoRemoteDataSource {
  final DatabaseHelper dbHelper;
  GitHubRepoRemoteDataSourceImpl({required this.dbHelper});
  @override
  Future<List<GitHubRepoModel>> getGitHubRepos({required int page}) async {
    const int perpage = 20;
    final now = DateTime.now();
    final sixtyDaysAgo = now.subtract(const Duration(days: 60));
    final formattedDate = sixtyDaysAgo.toIso8601String().split('T').first;

    final url =
        'https://api.github.com/search/repositories?q=created:>$formattedDate&sort=stars&order=desc&page=$page&per_page=$perpage';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final List<dynamic> items = data['items'];
      final repos =
          items.map((item) => GitHubRepoModel.fromJson(item)).toList();

      dbHelper.deleteAllRepos();
      for (var repo in repos) {
        await dbHelper.insertRepo(repo);
      }
      return repos;
    } else {
      throw ServerException();
    }
  }
}
