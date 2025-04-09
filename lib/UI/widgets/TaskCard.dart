import 'package:flutter/material.dart';

import '../../Data/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int index;
  final Color Function(taskStatus status) getChipColor;
  final void Function(int index) deleteTask;

  TaskCard({
    super.key,
    required this.task,
    required this.index,
    required this.getChipColor,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        subtitle: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.date, style: TextStyle(fontSize: 12)),
                Chip(
                  backgroundColor: getChipColor(task.status),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  label: Text(
                    task.status.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  visualDensity: VisualDensity(vertical: -4),

                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit, size: 20, color: Colors.green),
            ),
            SizedBox(width: 2),
            IconButton(
              onPressed: () => deleteTask(index),
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              task.taskDetails,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}