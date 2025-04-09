import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/Data/model/login_model.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/auth_controller.dart';
import 'package:flutter_task_manager_api_project/UI/screens/RegisterScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/UserHomeScreen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter_task_manager_api_project/UI/screens/ForgetPasswordEmailScreen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(2.w),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 2.h,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1.h,
                  children: [
                    Text(
                      'Get Started With',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Enter credential to Sign in',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                Visibility(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: Icon(Icons.double_arrow_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Column(
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: _onTapForgotPasswordButton,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?"),
                        TextButton(
                          onPressed: _onTapSignUpButton,
                          child: Text(
                            "Sign up",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _logIn();
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgetPasswordEmailScreen(),
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _logIn() async {
    _loginInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );
    _loginInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJason(response.data!);
      AuthController.saveUserInformation(
        loginModel.token,
        loginModel.userModel,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserHomeScreen()),
        (predicate) => false,
      );
    }else{
      showSnackBarMessage(context, response.errorMassage!, true);
    }
  }
}
