import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';

import '../../Data/model/task_model.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor, required this.taskCount,
  });

  final Future<void> Function(TaskModel task) deleteTask;
  final Color Function(String status) getChipColor;
  final Future<void> Function() taskCount;

  @override
  State<ProgressTaskScreen> createState() => ProgressTaskScreenState();
}

class ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _isGetProgressTaskInProgress = false;
  List<TaskModel> progressTaskList = [];

  @override
  void initState() {
    getProgressTasks();
    super.initState();
  }

  Future<void> getProgressTasks() async {
    _isGetProgressTaskInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getProgressTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      progressTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, "${response.errorMessage}", true);
    }

    _isGetProgressTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Visibility(
      replacement: CenterCircularProgressIndicator(),
      visible: !_isGetProgressTaskInProgress,
      child: ListView.separated(
        itemCount: progressTaskList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            task: progressTaskList[index],
            getChipColor: widget.getChipColor,
            deleteTask: widget.deleteTask,
            getTask: getProgressTasks,
            fetchTaskCount: widget.taskCount,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 5),
      ),
    );
  }
}
