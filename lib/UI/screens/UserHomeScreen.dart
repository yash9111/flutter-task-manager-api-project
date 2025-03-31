import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/screens/AddItem.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/summary_card.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_task_manager_api_project/Data/model/task.dart';

import '../widgets/TMAppBar.dart';
import 'CancelScreen.dart';
import 'CompletedTaskScreen.dart';
import 'NewTaskScreen.dart';
import 'ProgressTaskScreen.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({super.key, required this.tasks});

  List<Task> tasks = [];

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final bool _isFirstLogin = false;
  int selectedIndex = 0;

  void showWelcomeMessage() {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Welcome", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Prevent overflow issues
          children: [
            Text(args?['data'] ?? "No Data"),
            SizedBox(height: 10),
            Text('Sign In Successful'),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map;


    Color getChipColor(String status) {
      if (status == "new") {
        return Colors.blue;
      } else if (status == "Completed") {
        return Colors.green;
      } else if (status == "Progress") {
        return Colors.purple;
      } else if (status == "Canceled") {
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
                    if (widget.tasks.contains(deletedTask)){
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
      NewTaskScreen(tasks: widget.tasks, getChipColor: getChipColor, deleteTask: deleteTask),
      ProgressTaskScreen(tasks: widget.tasks, getChipColor: getChipColor, deleteTask: deleteTask),
      CompletedTaskScreen(tasks: widget.tasks, getChipColor: getChipColor, deleteTask: deleteTask),
      CancelScreen(tasks: widget.tasks, getChipColor: getChipColor, deleteTask: deleteTask),
    ];

    return Scaffold(
      appBar: TMAppBar(args: args),
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
            NavigationDestination(
              icon: Icon(Icons.new_label),
              label: 'New',
            ),
            NavigationDestination(
              icon: Icon(Icons.ac_unit_sharp),
              label: 'Progress',
            ),
            NavigationDestination(
              icon: Icon(Icons.done),
              label: 'Completed',
            ),
            NavigationDestination(
              icon: Icon(Icons.cancel),
              label: 'Canceled',
            ),
          ]),
    );
  }
}

