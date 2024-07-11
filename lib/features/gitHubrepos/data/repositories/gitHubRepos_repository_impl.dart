import 'package:assignmenr/core/errors/failure.dart';
import 'package:assignmenr/features/gitHubrepos/data/datasources/gitHubrepos_remote_data_source.dart';
import 'package:assignmenr/features/gitHubrepos/data/datasources/db_Helper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../business/repositories/getGitHubRepos_repository.dart';
import '../models/gitHubRepo_model.dart';

class GitHubRepoRepositoryImpl implements GitHubRepoRepository {
  final GitHubRepoRemoteDataSource dataSource;
  final Connectivity connectivity;
  final DatabaseHelper dbHelper;

  GitHubRepoRepositoryImpl(
      {required this.dataSource,
      required this.connectivity,
      required this.dbHelper});

  @override
  Future<Either<Failure, List<GitHubRepoModel>>> getRepos(
      {required int page}) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (!(connectivityResult == ConnectivityResult.none)) {
      try {
        List<GitHubRepoModel> remoteGitHubRepos =
            await dataSource.getGitHubRepos(page: page);

        return Right(remoteGitHubRepos);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        List<GitHubRepoModel> localGitHubRepos = await dbHelper.getRepos();
        return Right(localGitHubRepos);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
