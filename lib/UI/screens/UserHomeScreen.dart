import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/screens/add_task.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/summary_card.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_task_manager_api_project/Data/model/task.dart';

import '../widgets/TMAppBar.dart';
import 'CancelTaskScreen.dart';
import 'CompletedTaskScreen.dart';
import 'NewTaskScreen.dart';
import 'ProgressTaskScreen.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({super.key});

  final List<Task> tasks = [
    Task(
      "Daily Exercise",
      "30 minutes of cardio and stretching",
      taskStatus.New,
    ),
    Task(
      "Build Portfolio",
      "Create a personal website showcasing projects",
      taskStatus.Progress,
    ),
    Task("Memorize Quran", "Start with last 10 surahs", taskStatus.New),
    Task(
      "Contribute to Open Source",
      "Find a beginner-friendly GitHub repo",
      taskStatus.New,
    ),
    Task(
      "Improve English",
      "Read one non-fiction book per month",
      taskStatus.New,
    ),
    Task(
      "Start YouTube Channel",
      "Teach Flutter concepts weekly",
      taskStatus.New,
    ),
    Task(
      "Master DSA in Python",
      "Complete Abdul Bari's course",
      taskStatus.Progress,
    ),
    Task(
      "Travel to Turkey",
      "Explore Islamic history and architecture",
      taskStatus.New,
    ),
    Task("Learn Cooking", "Master 10 basic healthy meals", taskStatus.New),
    Task("Read a Self-Help Book", "Start with 'Atomic Habits'", taskStatus.New),
    Task(
      "Build a Flutter App",
      "Prayer reminder with hadith of the day",
      taskStatus.Progress,
    ),
    Task(
      "Get Internship",
      "Apply to 5 remote companies each week",
      taskStatus.Progress,
    ),
    Task("Charity Work", "Volunteer locally once a month", taskStatus.New),
    Task("Sleep Early", "Maintain a 10:30 PM bedtime", taskStatus.New),
    Task(
      "Digital Minimalism",
      "Avoid phone use 1 hour after waking up",
      taskStatus.Progress,
    ),
    Task("Tomorrow University", "Operating System Lab final", taskStatus.New),
    Task("Reading Quran", "Surah Baqarah", taskStatus.New),
    Task("Going Hajj", "After earning decent amount of money", taskStatus.New),
    Task("Learning Flutter", "Operating System Lab final", taskStatus.Progress),
    Task(
      "Daily Exercise",
      "30 minutes of cardio and stretching",
      taskStatus.New,
    ),
    Task(
      "Build Portfolio",
      "Create a personal website showcasing projects",
      taskStatus.Progress,
    ),
    Task("Memorize Quran", "Start with last 10 surahs", taskStatus.New),
    Task(
      "Contribute to Open Source",
      "Find a beginner-friendly GitHub repo",
      taskStatus.New,
    ),
    Task(
      "Improve English",
      "Read one non-fiction book per month",
      taskStatus.Complete,
    ),
    Task(
      "Start YouTube Channel",
      "Teach Flutter concepts weekly",
      taskStatus.Cancel,
    ),
    Task(
      "Master DSA in Python",
      "Complete Abdul Bari's course",
      taskStatus.Progress,
    ),
    Task(
      "Travel to Turkey",
      "Explore Islamic history and architecture",
      taskStatus.New,
    ),
    Task("Learn Cooking", "Master 10 basic healthy meals", taskStatus.Complete),
    Task(
      "Read a Self-Help Book",
      "Finished 'Atomic Habits'",
      taskStatus.Complete,
    ),
    Task(
      "Build a Flutter App",
      "Prayer reminder with hadith of the day",
      taskStatus.Progress,
    ),
    Task(
      "Get Internship",
      "Apply to 5 remote companies each week",
      taskStatus.Progress,
    ),
    Task("Charity Work", "Volunteer locally once a month", taskStatus.New),
    Task("Sleep Early", "Maintain a 10:30 PM bedtime", taskStatus.Cancel),
    Task(
      "Digital Minimalism",
      "Avoid phone use 1 hour after waking up",
      taskStatus.Complete,
    ),
    Task(
      "Learn Spanish",
      "Tried Duolingo but dropped after 3 days",
      taskStatus.Cancel,
    ),
  ];

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final bool _isFirstLogin = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color getChipColor(taskStatus status) {
      if (status == taskStatus.New) {
        return Colors.blue;
      } else if (status == taskStatus.Complete) {
        return Colors.green;
      } else if (status == taskStatus.Progress) {
        return Colors.purple;
      } else if (status == taskStatus.Cancel) {
        return Colors.red;
      }
      return Colors.white;
    }

    void deleteTask(int index) {
      Task deletedTask = widget.tasks[index];
      setState(() {
        widget.tasks.removeAt(index);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text("Task deleted"),
              Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (widget.tasks.contains(deletedTask)) {
                      return;
                    }
                    widget.tasks.insert(index, deletedTask);
                  });
                },
                child: Text("Undo", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> screens = [
      NewTaskScreen(
        tasks: widget.tasks,
        getChipColor: getChipColor,
        deleteTask: deleteTask,
      ),
      ProgressTaskScreen(
        tasks: widget.tasks,
        getChipColor: getChipColor,
        deleteTask: deleteTask,
      ),
      CompletedTaskScreen(
        tasks: widget.tasks,
        getChipColor: getChipColor,
        deleteTask: deleteTask,
      ),
      CancelScreen(
        tasks: widget.tasks,
        getChipColor: getChipColor,
        deleteTask: deleteTask,
      ),
    ];

    return Scaffold(
      appBar: TMAppBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10.w,
              children: [
                SummaryCard(title: "new", count: 09),
                SummaryCard(title: "progressing", count: 09),
                SummaryCard(title: "completed", count: 09),
                SummaryCard(title: "canceled", count: 09),
              ],
            ),
          ),
          Expanded(child: screens[selectedIndex]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            50,
          ), // Customize the border radius if needed
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTaskScreen(tasks: widget.tasks),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) => setState(() => selectedIndex = idx),
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.ac_unit_sharp),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Canceled'),
        ],
      ),
    );
  }
}
