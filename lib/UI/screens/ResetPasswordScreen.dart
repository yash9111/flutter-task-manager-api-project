import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:sizer/sizer.dart';
import '../widgets/show_snakbar_message.dart';
import 'log_in_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool recoverResetPasswordInProgress = false;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.h,
            children: [
              Text(
                'Set password',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'A 6 digit verification pin will send to your email Address',
                style: TextStyle(color: Colors.grey),
              ),
              Form(
                key: GlobalKey<FormState>(),
                child: Column(
                  children: [
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'New Password'),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: recoverResetPasswordInProgress == false,
                replacement: CircularProgressIndicator(),
                child: SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      _onTapSubmitButton();
                    },
                    child: Icon(Icons.double_arrow_sharp, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    recoverResetPassword();
  }

  Future<void> recoverResetPassword() async {
    if (newPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text &&
        confirmPasswordController.text.isNotEmpty) {
      Map<String, dynamic> recoverResetPasswordBody = {
        "email": widget.email,
        "OTP": widget.otp,
        "password": newPasswordController.text,
      };
      recoverResetPasswordInProgress = true;
      setState(() {});
      NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.recoverResetPasswordUrl,
        body: recoverResetPasswordBody,
      );
      recoverResetPasswordInProgress = false;
      setState(() {});

      if (response.isSuccess){
        showSnackBarMessage(context, "Login with your email and password");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LogInScreen()),
              (predicate) => false,
        );
      }

    }
  }
}
