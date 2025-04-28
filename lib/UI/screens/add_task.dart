import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/screens/UserHomeScreen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:sizer/sizer.dart';

import '../../Data/model/task_model.dart';

enum TaskStatus { New, Progress, Cancel, Complete }

extension TaskStatusExtension on TaskStatus {
  String get name {
    switch (this) {
      case TaskStatus.New:
        return 'New';
      case TaskStatus.Progress:
        return 'Progress';
      case TaskStatus.Cancel:
        return 'Cancel';
      case TaskStatus.Complete:
        return 'Complete';
    }
  }
}

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController newTaskController = TextEditingController();
  final TextEditingController newTaskDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TaskStatus selectedStatus = TaskStatus.New;
  bool _isAddingTask = false;

  Future<bool> addTask(
    String title,
    String description,
    String taskStatus,
  ) async {
    if (_isAddingTask) return false;
    _isAddingTask = true;
    setState(() {});

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.createTaskUrl,
      body: {"title": title, "description": description, "status": taskStatus},
    );

    _isAddingTask = false;
    setState(() {});

    if (response.isSuccess) {
      showSnackBarMessage(context, "Task added successfully.");
      return true;
    } else {
      showSnackBarMessage(context, "${response.errorMessage}", true);
      return false;
    }
  }

  @override
  void dispose() {
    newTaskController.dispose();
    newTaskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text(
                  'Add New Task',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'You can add task, also you can give descriptions',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 3.h),
                TextFormField(
                  controller: newTaskController,
                  decoration: const InputDecoration(hintText: 'New Task'),
                ),
                SizedBox(height: 1.5.h),
                TextFormField(
                  controller: newTaskDescriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Task description',
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 1.5.h),
                DropdownButtonFormField<TaskStatus>(
                  style: TextStyle(color: Colors.green),
                  iconEnabledColor: Colors.green,
                  value: selectedStatus,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedStatus = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Status',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      TaskStatus.values.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status.name),
                        );
                      }).toList(),
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _isAddingTask
                            ? null
                            : () async {
                              if (_formKey.currentState!.validate()) {
                                bool taskAdded = await addTask(
                                  newTaskController.text.trim(),
                                  newTaskDescriptionController.text.trim(),
                                  selectedStatus.name,
                                );
                                if (taskAdded) {
                                  Navigator.pop(context, true);
                                }
                              }
                            },
                    child:
                        _isAddingTask
                            ? CircularProgressIndicator(color: Colors.white)
                            : const Icon(Icons.check, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
