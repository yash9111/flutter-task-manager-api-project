import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:sizer/sizer.dart';

import '../../Data/model/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  TextEditingController newTaskController = TextEditingController();
  TextEditingController newTaskDescriptionController = TextEditingController();

  void dispose() {
    newTaskController.dispose();
    newTaskDescriptionController.dispose();
    super.dispose();
  }

  void addTask(String title, String description){
    Task newTask = Task(title, description, taskStatus.New);
    widget.tasks.add(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child:  SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child:Form(
            key: GlobalKey(),
            child: Column(
              spacing: 1.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1.h,
                  children: [
                    Text(
                      'Add new Task',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'You can add task, also you can give descriptions',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Form(
                  child: Column(
                    spacing: 1.h,
                    children: [
                      TextFormField(
                        controller: newTaskController,
                        decoration: InputDecoration(hintText: 'New Task'),
                      ),
                      TextFormField(
                        controller: newTaskDescriptionController,
                        decoration: InputDecoration(hintText: 'Task description'),
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        addTask(newTaskController.text, newTaskDescriptionController.text);
                        Navigator.pop(context);
                      });
                    },
                    child: Icon(Icons.double_arrow_sharp, color: Colors.white),
                  ),
                ),

              ],
            ),
          ),
        ),
      )
    );
  }
}
