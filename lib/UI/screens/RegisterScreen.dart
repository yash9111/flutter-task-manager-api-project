import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController joinEmailController = TextEditingController();
  TextEditingController joinFNameController = TextEditingController();
  TextEditingController joinLNameController = TextEditingController();
  TextEditingController joinPhoneController = TextEditingController();
  TextEditingController joinPasswordController = TextEditingController();

  @override
  void dispose() {
    joinEmailController.dispose();
    joinFNameController.dispose();
    joinLNameController.dispose();
    joinPasswordController.dispose();
    joinPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backgroundsvg(
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
                      'Join with us',
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
                        controller: joinEmailController,
                        decoration: InputDecoration(hintText: 'Email'),
                      ),
                      TextFormField(
                        controller: joinFNameController,
                        decoration: InputDecoration(hintText: 'First Name'),
                      ),
                      TextFormField(
                        controller: joinLNameController,
                        decoration: InputDecoration(hintText: 'Last Name'),
                      ),
                      TextFormField(
                        controller: joinPhoneController,
                        decoration: InputDecoration(hintText: 'Mobile'),
                      ),
                      TextFormField(
                        controller: joinPasswordController,
                        decoration: InputDecoration(hintText: 'Password'),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home', arguments: {
                        'data' : "${joinFNameController.text} ${joinLNameController.text}",
                        'email': "${joinEmailController.text}"
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
