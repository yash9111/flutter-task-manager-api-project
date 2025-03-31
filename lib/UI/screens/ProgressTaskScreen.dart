import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';

import '../../Data/model/task.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key, required this.tasks, required this.deleteTask, required this.getChipColor});

  final List<Task> tasks;
  final void Function(int) deleteTask;
  final Color Function(String) getChipColor;

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    List<Task> completedTask = widget.tasks.where((task) => task.status == "Progress").toList();
    return ListView.separated(
      itemCount: completedTask.length,
      itemBuilder: (context, index) {
        return TaskCard(task: completedTask[index], index: index, getChipColor: widget.getChipColor, deleteTask: widget.deleteTask);

      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),);
  }
}
