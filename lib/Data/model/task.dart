import 'package:date_time_format/date_time_format.dart';

class Task {
  String title;
  String taskDetails;
  String status;
  String date;

  Task(this.title, this.taskDetails, this.status)
      : date = DateTimeFormat.format(DateTime.now(), format: DateTimeFormats.american);
}