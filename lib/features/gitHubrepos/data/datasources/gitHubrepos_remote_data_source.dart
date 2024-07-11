import 'dart:convert';

import 'package:assignmenr/features/gitHubrepos/data/datasources/db_Helper.dart';

import '../../../../../core/errors/exceptions.dart';
import '../models/gitHubRepo_model.dart';
import 'package:http/http.dart' as http;

abstract class GitHubRepoRemoteDataSource {
  Future<List<GitHubRepoModel>> getGitHubRepos(
      {required int page, required int daysAgo});
}
//GitHubRepoRemoteDataSource abstract class -->Definition

class GitHubRepoRemoteDataSourceImpl implements GitHubRepoRemoteDataSource {
  final DatabaseHelper dbHelper;
  GitHubRepoRemoteDataSourceImpl({required this.dbHelper});
  @override
  Future<List<GitHubRepoModel>> getGitHubRepos(
      {required int page, required int daysAgo}) async {
    const int perpage = 20;
    //getting 20 data per page
    final now = DateTime.now();
    final DaysAgo = now.subtract(Duration(days: daysAgo));
    //DaysAgo will change according to the user FAB 30 or 60
    final formattedDate = DaysAgo.toIso8601String().split('T').first;

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
      //Deleting the last repos
      for (var repo in repos) {
        await dbHelper.insertRepo(repo);
      }
      //Caching the last api called repo data
      return repos;
    } else {
      throw ServerException();
    }
  }
}
