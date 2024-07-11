import 'package:assignmenr/features/tasks/widgets/taskItem_progress.dart';
import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final Map<String, dynamic> task;

  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1B),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.grey)),
        title: const Text(
          'Task Details',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.question_answer_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task['name']!,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(task['color'])),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Chip(
                    backgroundColor: const Color(0xFF1B1B1B),
                    label: const Text('UI/UX Design',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    side: BorderSide(color: Color(task['color'])),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    backgroundColor: const Color(0xFF1B1B1B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    side: BorderSide(color: Color(task['color'])),
                    label: Text(task['priority']!,
                        style: const TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Additional Information',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                  'Incorporate feedback from client ${task['name']} into the color palette for the mobile app design.',
                  style: const TextStyle(
                    color: Colors.grey,
                  )),
              const SizedBox(height: 18),
              const Text(
                'Task Progress',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              TaskProgressItem(
                title: 'UX for App',
                description:
                    'Optimize app navigation as per client feedback for an improved user experience.',
                color: task['color'],
              ),
              TaskProgressItem(
                title: 'Icon selections',
                description:
                    'Adapt iconography to align with client preferences for a personalized touch.',
                color: task['color'],
              ),
              TaskProgressItem(
                title: 'UI Choices',
                description:
                    'Present varied UI choices to clients seeking input for brand-aligned visual elements.',
                color: task['color'],
              ),
              TaskProgressItem(
                title: 'Micro Interactions',
                description:
                    'Refine UI based on James micro interactions feedback for an enhanced user experience.',
                color: task['color'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
