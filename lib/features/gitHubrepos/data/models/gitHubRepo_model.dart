import 'package:assignmenr/core/constants/constants.dart';
import 'package:assignmenr/features/gitHubrepos/business/entities/gitHubRepo_entity.dart';

class GitHubRepoModel extends GitHubRepoEntity {
  GitHubRepoModel({
    int? id,
    required String name,
    required String description,
    required int stars,
    required String ownerUsername,
    required String ownerAvatar,
    required String htmlUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime pushedAt,
    required int watchersCount,
    required String visibility,
    required int forks,
    required int openIssues,
    required bool allowForking,
  }) : super(
          id: id,
          name: name,
          description: description,
          stars: stars,
          ownerAvatar: ownerAvatar,
          ownerUsername: ownerUsername,
          htmlUrl: htmlUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
          pushedAt: pushedAt,
          watchersCount: watchersCount,
          visibility: visibility,
          forks: forks,
          openIssues: openIssues,
          allowForking: allowForking,
        );

  factory GitHubRepoModel.fromJson(Map<String, dynamic> json) {
    return GitHubRepoModel(
      id: json[kId],
      name: json[kName],
      description: json[kDescription] ?? '',
      stars: json[kStarsCount],
      ownerUsername: json[kOwner][kLogin],
      ownerAvatar: json[kOwner][kAvatarUrl],
      htmlUrl: json[kHtmlUrl],
      createdAt: DateTime.parse(json[kCreatedAt]),
      updatedAt: DateTime.parse(json[kUpdatedAt]),
      pushedAt: DateTime.parse(json[kPushedAt]),
      watchersCount: json[kWatchersCount],
      visibility: json[kVisibility],
      forks: json[kForks],
      openIssues: json[kOpenIssues],
      allowForking: json[kAllowForking],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      kId: id,
      kName: name,
      kDescription: description,
      kStars: stars,
      kOwnerUsername: ownerUsername,
      kOwnerAvatar: ownerAvatar,
      kHtmlUrl: htmlUrl,
      kCreatedAt: createdAt.toIso8601String(),
      kUpdatedAt: updatedAt.toIso8601String(),
      kPushedAt: pushedAt.toIso8601String(),
      kWatchersCount: watchersCount,
      kVisibility: visibility,
      kForks: forks,
      kOpenIssues: openIssues,
      kAllowForking: allowForking ? 1 : 0,
    };
  }

  factory GitHubRepoModel.fromMap(Map<String, dynamic> map) {
    return GitHubRepoModel(
      id: map[kId],
      name: map[kName],
      description: map[kDescription],
      stars: map[kStars],
      ownerUsername: map[kOwnerUsername],
      ownerAvatar: map[kOwnerAvatar],
      htmlUrl: map[kHtmlUrl],
      createdAt: DateTime.parse(map[kCreatedAt]),
      updatedAt: DateTime.parse(map[kUpdatedAt]),
      pushedAt: DateTime.parse(map[kPushedAt]),
      watchersCount: map[kWatchersCount],
      visibility: map[kVisibility],
      forks: map[kForks],
      openIssues: map[kOpenIssues],
      allowForking: map[kAllowForking] == 1,
    );
  }
}
