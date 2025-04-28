import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/TaskCard.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:sizer/sizer.dart';

import '../../Data/model/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({
    super.key,
    required this.deleteTask,
    required this.getChipColor,
  });

  final Future<void> Function(TaskModel task) deleteTask;
  final Color Function(String status) getChipColor;

  @override
  State<NewTaskScreen> createState() => NewTaskScreenState();
}

class NewTaskScreenState extends State<NewTaskScreen> {
  bool _isGetCompletedTaskIsInProgress = false;
  List<TaskModel> newTaskList = [];

  Future<void> getNewTask() async {
    _isGetCompletedTaskIsInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.getNewTaskUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      newTaskList = taskListModel.taskList;
    } else {
      showSnackBarMessage(context, "$response.errorMessage", true);
    }

    _isGetCompletedTaskIsInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    getNewTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: newTaskList.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: newTaskList[index],
          getChipColor: widget.getChipColor,
          deleteTask: widget.deleteTask,
          getTask: getNewTask,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 5),
    );
  }
}
