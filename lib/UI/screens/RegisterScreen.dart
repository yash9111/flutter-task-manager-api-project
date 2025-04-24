import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/CenterCircullarProgressIndicator.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/show_snakbar_message.dart';
import 'package:sizer/sizer.dart';
import 'package:email_validator/email_validator.dart';

import '../../Data/utils/urls.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _registrationInProgress = false;

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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 1.h,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: joinEmailController,
                        decoration: const InputDecoration(hintText: 'Email'),
                        validator: (String? value) {
                          String email = value?.trim() ?? '';
                          if (EmailValidator.validate(email) == false) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: joinFNameController,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: joinLNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        controller: joinPhoneController,
                        decoration: const InputDecoration(hintText: 'Mobile'),
                        validator: (String? value) {
                          String phone = value?.trim() ?? '';
                          RegExp regExp = RegExp(
                            r"^(?:\+?88|0088)?01[15-9]\d{8}$",
                          );
                          if (regExp.hasMatch(phone) == false) {
                            return 'Enter your valid phone';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: joinPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: 'Password'),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                            return 'Enter your password more than 6 letters';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _registrationInProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(
                        Icons.double_arrow_sharp,
                        color: Colors.white,
                      ),
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
                          MaterialPageRoute(
                            builder: (context) => LogInScreen(),
                          ),
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
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    _registrationInProgress = true;

    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": joinEmailController.text.trim(),
      "firstName": joinFNameController.text.trim(),
      "lastName": joinLNameController.text.trim(),
      "mobile": joinPhoneController.text.trim(),
      "password": joinPasswordController.text,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );

    _registrationInProgress = false;
    setState(() {});

    void _clearTextField(){
      joinEmailController.clear();
      joinFNameController.clear();
      joinLNameController.clear();
      joinPhoneController.clear();
      joinPasswordController.clear();
    }

    if (response.isSuccess){
      _clearTextField();
      showSnackBarMessage(context, 'User registered successfully!');
      Navigator.pop(context);
    }else{
      showSnackBarMessage(context, '${response.errorMessage}', true);
    }
  }

  @override
  void dispose() {
    joinEmailController.dispose();
    joinFNameController.dispose();
    joinLNameController.dispose();
    joinPasswordController.dispose();
    joinPhoneController.dispose();
    super.dispose();
  }
}
