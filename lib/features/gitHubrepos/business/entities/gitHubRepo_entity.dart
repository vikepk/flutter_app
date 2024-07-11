//Entity

class GitHubRepoEntity {
  final int? id;
  final String name;
  final String description;
  final int stars;
  final String ownerUsername;
  final String ownerAvatar;
  final String htmlUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime pushedAt;
  final int watchersCount;
  final String visibility;
  final int forks;
  final int openIssues;
  final bool allowForking;

  GitHubRepoEntity({
    this.id,
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerUsername,
    required this.ownerAvatar,
    required this.htmlUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.watchersCount,
    required this.visibility,
    required this.forks,
    required this.openIssues,
    required this.allowForking,
  });
}
