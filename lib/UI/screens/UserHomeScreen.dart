import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_Status_Count.dart';
import 'package:flutter_task_manager_api_project/UI/screens/add_task.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/summary_card.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_task_manager_api_project/Data/model/Task_Status_Count_List_Model.dart';
import 'package:flutter_task_manager_api_project/Data/model/task_model.dart';
import '../../Data/utils/urls.dart';
import '../widgets/TMAppBar.dart';
import 'CancelTaskScreen.dart';
import 'CompletedTaskScreen.dart';
import 'NewTaskScreen.dart';
import 'ProgressTaskScreen.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int selectedIndex = 0;

  int newTaskCount = 0;
  int completeTaskCount = 0;
  int progressTaskCount = 0;
  int cancelTaskCount = 0;

  final GlobalKey<NewTaskScreenState> _newTaskKey = GlobalKey();
  final GlobalKey<ProgressTaskScreenState> _progressTaskKey = GlobalKey();
  final GlobalKey<CompletedTaskScreenState> _completedTaskKey = GlobalKey();
  final GlobalKey<CancelScreenState> _cancelTaskKey = GlobalKey();

  late NewTaskScreen _newTaskScreen;
  late ProgressTaskScreen _progressTaskScreen;
  late CompletedTaskScreen _completedTaskScreen;
  late CancelScreen _cancelScreen;

  Color getChipColor(String status) {
    if (status == "New") {
      return Colors.blue;
    } else if (status == "Complete") {
      return Colors.green;
    } else if (status == "Progress") {
      return Colors.purple;
    } else if (status == "Cancel") {
      return Colors.red;
    }
    return Colors.white;
  }

  Future<bool> deleteTask(TaskModel task) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteATaskUrl(task.id),
    );
    if (response.isSuccess) {
      showSnackBarMessage(
        context,
        "${task.title} has been deleted successfully.",
      );
      _refreshCurrentScreen();
      await fetchTaskCount();
      return true;
    } else {
      showSnackBarMessage(context, "${response.errorMessage}");
      return false;
    }
  }

  void _refreshCurrentScreen() async{
    if (selectedIndex == 0) {
      _newTaskKey.currentState?.getNewTask();
    } else if (selectedIndex == 1) {
      _progressTaskKey.currentState?.getProgressTasks();
    } else if (selectedIndex == 2) {
      _completedTaskKey.currentState?.getCompletedTask();
    } else if (selectedIndex == 3) {
      _cancelTaskKey.currentState?.getCancelledTasks();
    }
    await fetchTaskCount();
  }

  Future<void> fetchTaskCount() async{
    NetworkResponse response = await NetworkClient.getRequest(url: Urls.getTaskStatusCountUrl);

    int newCount = 0;
    int progressCount = 0;
    int completeCount = 0;
    int cancelCount = 0;

    if (response.isSuccess){
      var taskCountList = TaskStatusCountListModel.fromJson(response.data!);
        for (TaskStatusCountModel taskCount in taskCountList.statusCountList){
          if (taskCount.status == "New"){
            newCount = taskCount.count;
          }
          else if (taskCount.status == "Progress"){
            progressCount = taskCount.count;
          }
          else if (taskCount.status == "Complete"){
            completeCount = taskCount.count;
          }
          else if (taskCount.status == "Cancel"){
            cancelCount = taskCount.count;
          }
        }

        setState(() {
          newTaskCount = newCount;
          progressTaskCount = progressCount;
          cancelTaskCount = cancelCount;
          completeTaskCount = completeCount;
        });
    }
  }

  @override
  void initState() {
    super.initState();

    _newTaskScreen = NewTaskScreen(
      key: _newTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: fetchTaskCount,
    );
    _progressTaskScreen = ProgressTaskScreen(
      key: _progressTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: fetchTaskCount,
    );
    _completedTaskScreen = CompletedTaskScreen(
      key: _completedTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: fetchTaskCount,
    );
    _cancelScreen = CancelScreen(
      key: _cancelTaskKey,
      getChipColor: getChipColor,
      deleteTask: deleteTask,
      taskCount: fetchTaskCount,
    );

    fetchTaskCount();
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      _newTaskScreen,
      _progressTaskScreen,
      _completedTaskScreen,
      _cancelScreen,
    ];

    return Scaffold(
      appBar: TMAppBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10.w,
              children: [
                SummaryCard(title: "New", count: newTaskCount),
                SummaryCard(title: "progressing", count: progressTaskCount),
                SummaryCard(title: "completed", count: completeTaskCount),
                SummaryCard(title: "canceled", count: cancelTaskCount),
              ],
            ),
          ),
          Expanded(child: screens[selectedIndex]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
          if (result == true) {
            _refreshCurrentScreen();
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) {
          setState(() {
            selectedIndex = idx;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.ac_unit_sharp),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Canceled'),
        ],
      ),
    );
  }
}
