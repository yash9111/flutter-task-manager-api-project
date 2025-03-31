import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';

import '../../Data/model/task.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key, required this.tasks, required this.deleteTask, required this.getChipColor});

  final List<Task> tasks;
  final void Function(int) deleteTask;
  final Color Function(String) getChipColor;

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    List<Task> completedTask = widget.tasks.where((task) => task.status == "Completed").toList();
    return ListView.separated(
      itemCount: completedTask.length,
      itemBuilder: (context, index) {
        return TaskCard(task: completedTask[index], index: index, getChipColor: widget.getChipColor, deleteTask: widget.deleteTask);

      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),);
  }
}
