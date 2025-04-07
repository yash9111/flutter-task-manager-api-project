import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/screens/RegisterScreen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter_task_manager_api_project/UI/screens/ForgetPasswordEmailScreen.dart';
import 'package:sizer/sizer.dart';

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
                  child: ElevatedButton(
                    onPressed: _onTapSignInButton,
                    child: Icon(Icons.double_arrow_outlined),
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
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _logIn() async{
    _loginInProgress = true;
    setState(() {});

  }

}
