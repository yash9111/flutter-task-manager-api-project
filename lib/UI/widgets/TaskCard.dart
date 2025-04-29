import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import '../../Data/model/task_model.dart';
import 'package:date_time_format/date_time_format.dart';

import '../../Data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final Color Function(String status) getChipColor;
  final Future<void> Function(TaskModel task) deleteTask;
  final Future<void> Function() getTask;
  final Future<void> Function() fetchTaskCount;

  TaskCard({
    super.key,
    required this.task,
    required this.getChipColor,
    required this.deleteTask, required this.getTask,
    required this.fetchTaskCount,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
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
                Text(
                  (DateTime.parse(widget.task.createdDate).format('D, M j, H:i, Y')),
                  style: TextStyle(color: Color(0xff358539), fontSize: 12),
                ),
                Chip(
                  backgroundColor: widget.getChipColor(widget.task.status),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  label: Text(
                    widget.task.status,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  visualDensity: VisualDensity(vertical: -4),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                _updateTaskStatus(context, widget.task);
              },
              icon: Icon(Icons.edit, size: 20, color: Colors.green),
            ),
            SizedBox(width: 2),
            IconButton(
              onPressed: () => widget.deleteTask(widget.task),
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(widget.task.description, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTaskStatus(BuildContext context, TaskModel task) async {
    List<String> statusList = ['New', 'Progress', 'Complete', 'Cancel'];
    String selectedStatus = task.status;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update task status", textAlign: TextAlign.center),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: statusList.map((status) {
                    return RadioMenuButton(
                      value: status,
                      groupValue: selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value.toString();
                        });
                      },
                      child: Chip(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        label: Text(
                          status,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        visualDensity: VisualDensity(vertical: -4),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                NetworkResponse response = await NetworkClient.getRequest(
                  url: Urls.updateTaskStatusUrl(task.id, selectedStatus),
                );
                if (response.isSuccess) {
                  showSnackBarMessage(context, '${task.title} has been updated to $selectedStatus');
                  await widget.getTask(); // Corrected function call
                } else {
                  showSnackBarMessage(context, '${task.title} update failed!', true);
                }
                await widget.fetchTaskCount();
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }


}
