import 'package:assignmenr/features/tasks/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MainTaskPage extends StatefulWidget {
  const MainTaskPage({super.key});

  @override
  _MainTaskPageState createState() => _MainTaskPageState();
}

class _MainTaskPageState extends State<MainTaskPage> {
  int selectedDayIndex = 0;
  final List<DateTime> days = List.generate(30, (index) {
    final now = DateTime.now();

    return now.add(Duration(days: index));
  });

  //List of 30 days for the horizontal calendar

//Static Task List with differernt color
  final List<Map<String, dynamic>> tasks = [
    {
      'name': 'Sarah',
      'description':
          'Collaborate with client Sarah on wireframe revisions for the homepage.',
      'priority': 'High Priority',
      'color': 0xFFCADE65
    },
    {
      'name': 'James',
      'description':
          'Incorporate feedback from client James into the color palette for the mobile app design.',
      'priority': 'High Priority',
      'color': 0xFFFA8772,
    },
    {
      'name': 'Alex',
      'description':
          'Conduct a virtual presentation with client Alex to showcase the interactive prototypes and gather input.',
      'priority': 'High Priority',
      'color': 0xFFF8F2DA
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello, John',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Organize Tasks,\nBoost productivity with us.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          DateFormat('d, MMMM yyyy')
                              .format(days[selectedDayIndex]),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFCADE65)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 0.5)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.grey,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 70,
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDayIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Center(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.grey,
                                      size: 10,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      DateFormat('d').format(days[index]),
                                      style: TextStyle(
                                          color: selectedDayIndex == index
                                              ? const Color(0xFFCADE65)
                                              : Colors.grey,
                                          fontSize: selectedDayIndex == index
                                              ? 20
                                              : 16.0,
                                          fontWeight: selectedDayIndex == index
                                              ? FontWeight.w600
                                              : FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .push('/taskdetail', extra: {'task': tasks[index]});
                    },
                    child: Task_Tile(
                      tile: tasks[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
