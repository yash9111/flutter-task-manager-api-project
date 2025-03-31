import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';

import '../../Data/model/task.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.tasks, required this.deleteTask, required this.getChipColor});

  final List<Task> tasks;
  final void Function(int) deleteTask;
  final Color Function(String) getChipColor;

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    List<Task> newTasks = widget.tasks.where((task) => task.status == "new").toList();
    return ListView.separated(
      itemCount: newTasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: newTasks[index], index: index, getChipColor: widget.getChipColor, deleteTask: widget.deleteTask);

      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),);
  }
}
