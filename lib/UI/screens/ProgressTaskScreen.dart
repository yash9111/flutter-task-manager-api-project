import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';

import '../../Data/model/task.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key, required this.tasks, required this.deleteTask, required this.getChipColor});

  final List<Task> tasks;
  final void Function(int) deleteTask;
  final Color Function(taskStatus) getChipColor;

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    List<Task> progressTasks = widget.tasks.where((task) => task.status == taskStatus.Progress).toList();
    return ListView.separated(
      itemCount: progressTasks.length,
      itemBuilder: (context, index) {
        if (index == progressTasks.length - 1){
          return Column(
            children: [
              TaskCard(
                task: progressTasks[index],
                index: index,
                getChipColor: widget.getChipColor,
                deleteTask: widget.deleteTask,
              ),
              SizedBox(height: 67),
            ],
          );
        }
        return TaskCard(task: progressTasks[index], index: index, getChipColor: widget.getChipColor, deleteTask: widget.deleteTask);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),);
  }
}
