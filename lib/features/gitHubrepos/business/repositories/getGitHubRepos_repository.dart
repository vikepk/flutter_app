import 'package:assignmenr/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/gitHubRepo_entity.dart';

abstract class GitHubRepoRepository {
  Future<Either<Failure, List<GitHubRepoEntity>>> getRepos({required int page});
}
