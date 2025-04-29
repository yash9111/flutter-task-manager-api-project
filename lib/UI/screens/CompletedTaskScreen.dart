import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';

import '../../Data/model/task_model.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor, required this.taskCount,
  });

  final Future<void> Function(TaskModel task) deleteTask;
  final Color Function(String status) getChipColor;
  final Future<void> Function() taskCount;

  @override
  State<CompletedTaskScreen> createState() => CompletedTaskScreenState();
}

class CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _isGetCompletedTaskIsInProgress = false;
  List<TaskModel> completedTaskList = [];

  @override
  void initState() {
    getCompletedTask();
    super.initState();
  }

  Future<void> getCompletedTask() async {
    _isGetCompletedTaskIsInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getCompletedTaskUrl,
    );

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      completedTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, "${response.errorMessage}", true);
    }

    _isGetCompletedTaskIsInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Visibility(
      replacement: CenterCircularProgressIndicator(),
      visible: !_isGetCompletedTaskIsInProgress,
      child: ListView.separated(
        itemCount: completedTaskList.length,
        itemBuilder: (context, index) {
          return TaskCard(
            task: completedTaskList[index],
            getChipColor: widget.getChipColor,
            deleteTask: widget.deleteTask,
            getTask: getCompletedTask,
            fetchTaskCount: widget.taskCount,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 5),
      ),
    );
  }
}
