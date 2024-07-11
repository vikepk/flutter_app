import 'package:assignmenr/features/gitHubrepos/business/entities/gitHubRepo_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GithubRepoItem extends StatelessWidget {
  final GitHubRepoEntity repo;

  const GithubRepoItem({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/repodetail', extra: {'repo': repo});
      },
      child: Card(
        color: const Color(0xFF272727),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: repo.ownerAvatar,
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 24.0,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                errorWidget: (context, url, error) => const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 24.0,
                  child: Icon(Icons.error, color: Colors.white),
                ),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 24.0,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repo.name,
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      repo.description,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(
                          '${repo.stars}',
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
