import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/gitHubRepo_entity.dart';
import '../repositories/getGitHubRepos_repository.dart';

class GetRepos {
  final GitHubRepoRepository gitHubRepoRepository;

  GetRepos({required this.gitHubRepoRepository});

  Future<Either<Failure, List<GitHubRepoEntity>>> getRepos(
      {required int page}) async {
    return await gitHubRepoRepository.getRepos(page: page);
  }
}
