import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';

import '../../Data/model/task_model.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor,
  });

  final Future<void> Function(TaskModel task) deleteTask;
  final Color Function(String status) getChipColor;

  @override
  State<CancelScreen> createState() => CancelScreenState();
}

class CancelScreenState extends State<CancelScreen> {
  bool _isGetCancelledTaskInProgress = false;
  List<TaskModel> cancelledTaskList = [];

  @override
  void initState() {
    getCancelledTasks();
    super.initState();
  }

  Future<void> getCancelledTasks() async {
    _isGetCancelledTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getCanceledTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      cancelledTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, "${response.errorMessage}", true);
    }

    _isGetCancelledTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: cancelledTaskList.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: cancelledTaskList[index],
          getChipColor: widget.getChipColor,
          deleteTask: widget.deleteTask,
          getTask: getCancelledTasks,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
    );
  }
}
