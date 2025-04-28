class Urls{
  //=============Base url====================
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  //=============Authentication==============
  static const String registerUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';

  //=============Recover account=============
  static const String recoverVerifyEmailUrl = '$_baseUrl/RecoverVerifyEmail/';
  static const String recoverVerifyPinUrl = '$_baseUrl/RecoverVerifyOtp/';
  static const String recoverResetPasswordUrl = "$_baseUrl/RecoverResetPassword";

  //=============Fetch task data=============
  static const String getCompletedTaskUrl = '$_baseUrl/listTaskByStatus/Complete';
  static const String getNewTaskUrl = '$_baseUrl/listTaskByStatus/New';
  static const String getProgressTaskUrl = '$_baseUrl/listTaskByStatus/Progress';
  static const String getCanceledTaskUrl = '$_baseUrl/listTaskByStatus/Cancel';

  //=============Task create/delete==========
  static const String createTaskUrl = '$_baseUrl/createTask';
  static String deleteATaskUrl (String taskId) => '$_baseUrl/deleteTask/$taskId';

  //=============Task status update==========
  static String updateTaskStatusUrl (String taskId, String status) => '$_baseUrl/updateTaskStatus/$taskId/$status';
}