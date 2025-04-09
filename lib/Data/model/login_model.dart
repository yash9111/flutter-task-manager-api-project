import 'package:flutter_task_manager_api_project/Data/model/user_model.dart';

class LoginModel{
  late final String status;
  late final String token;
  late UserModel userModel;

  LoginModel.fromJason(Map<String, dynamic> jsonData){
    status = jsonData['status'] ?? '';
    userModel = UserModel.fromJson(jsonData['data'] ?? {});
    token = jsonData['token'] ?? '';
  }
}