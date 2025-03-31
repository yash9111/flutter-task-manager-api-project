import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter_task_manager_api_project/UI/screens/sign_up_screen.dart';
import 'package:sizer/sizer.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backgroundsvg(
        child: Container(
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
                  TextFormField(decoration: InputDecoration(hintText: 'Email')),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: Icon(
                        Icons.double_arrow_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password ?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
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
      ),
    );
  }
}
