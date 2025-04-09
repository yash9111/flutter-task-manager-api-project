import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';

import '../../Data/model/task.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({super.key, required this.tasks, required this.deleteTask, required this.getChipColor});

  final List<Task> tasks;
  final void Function(int) deleteTask;
  final Color Function(taskStatus) getChipColor;

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  @override
  Widget build(BuildContext context) {
    List<Task> canceledTasks = widget.tasks.where((task) => task.status == taskStatus.Cancel).toList();
    return ListView.separated(
      itemCount: canceledTasks.length,
      itemBuilder: (context, index) {
        if (index == canceledTasks.length - 1){
          return Column(
            children: [
              TaskCard(
                task: canceledTasks[index],
                index: index,
                getChipColor: widget.getChipColor,
                deleteTask: widget.deleteTask,
              ),
              SizedBox(height: 67),
            ],
          );
        }
        return TaskCard(task: canceledTasks[index], index: index, getChipColor: widget.getChipColor, deleteTask: widget.deleteTask);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),);
  }
}
