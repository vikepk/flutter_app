import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final Map<String, dynamic> task;

  TaskDetailPage({required this.task});

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
              const SizedBox(height: 8),
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
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

class TaskProgressItem extends StatefulWidget {
  final String title;
  final String description;
  final int color;

  TaskProgressItem(
      {required this.title, required this.description, required this.color});

  @override
  _TaskProgressItemState createState() => _TaskProgressItemState();
}

class _TaskProgressItemState extends State<TaskProgressItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            side: BorderSide(color: Colors.grey),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
            activeColor: Color(widget.color),
            checkColor: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
