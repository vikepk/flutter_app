import 'package:flutter/material.dart';
import 'package:assignmenr/features/gitHubrepos/business/entities/gitHubRepo_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubRepoDetailPage extends StatelessWidget {
  final GitHubRepoEntity repo;

  GitHubRepoDetailPage({required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: const Color(0xFF1B1B1B),
        title: Text(repo.name),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: repo.ownerAvatar,
                  placeholder: (context, url) => const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50.0,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 50.0,
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 50.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  repo.ownerUsername,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                repo.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                repo.description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.star, 'Stars Gazers: ${repo.stars}'),
              _buildInfoRow(
                  Icons.visibility, 'Watchers: ${repo.watchersCount}'),
              _buildInfoRow(Icons.lock_open, 'Visibility: ${repo.visibility}'),
              _buildInfoRow(Icons.call_split, 'Forks: ${repo.forks}'),
              _buildInfoRow(
                  Icons.bug_report, 'Open Issues: ${repo.openIssues}'),
              _buildInfoRow(Icons.fork_right,
                  'Allow Forking: ${repo.allowForking ? 'Yes' : 'No'}'),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.link, 'View on GitHub ',
                  isLink: true, url: repo.htmlUrl),
              //urlLauncher
              const SizedBox(height: 16),
              _buildInfoRow(Icons.calendar_today,
                  'Created At: ${_formatDate(repo.createdAt)}'),
              _buildInfoRow(
                  Icons.update, 'Updated At: ${_formatDate(repo.updatedAt)}'),
              _buildInfoRow(
                  Icons.push_pin, 'Last Push: ${_formatDate(repo.pushedAt)}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text,
      {bool isLink = false, String? url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isLink
                ? InkWell(
                    onTap: () {
                      if (url != null) {
                        _launchURL(url);
                      }
                    },
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  void _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
