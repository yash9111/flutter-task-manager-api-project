import 'package:flutter_task_manager_api_project/UI/screens/RegisterScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/UserHomeScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:sizer/sizer.dart';

import '../../Data/model/task.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {

  TextEditingController setPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    setPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundSvg(
        child: Form(
          key: GlobalKey(),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
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
                      'Set Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Minimum length of password is 8 character, with latter and number combination',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 1.h,
                    children: [
                      TextFormField(
                        controller: setPasswordController,
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(hintText: 'Confirm password'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home', arguments: {
                        'data' : "Ragib Shahariar",
                        'email': "ragibshahriar07@gmail.com"
                      });
                    },
                    child: Icon(Icons.double_arrow_sharp, color: Colors.white),
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInScreen()));
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
      ),
    );
  }
}
