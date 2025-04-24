import 'package:flutter_task_manager_api_project/Data/Services/network_client.dart';
import 'package:flutter_task_manager_api_project/UI/screens/ResetPasswordScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_task_manager_api_project/Data/utils/urls.dart';

import '../widgets/show_snakbar_message.dart';

class ForgetPasswordPinVerificationScreen extends StatefulWidget {
  const ForgetPasswordPinVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<ForgetPasswordPinVerificationScreen> createState() => _ForgetPasswordPinVerificationScreenState();
}

class _ForgetPasswordPinVerificationScreenState extends State<ForgetPasswordPinVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool pinVerificationInProgress = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _pasteClipboard(i);
        }
      });
    }
  }

  Future<void> _pasteClipboard(int index) async {
    ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      String clipBoardText = clipboardData.text!;
      if (clipBoardText.isNotEmpty) {
        setState(() {
          for (int i = 0; i < _controllers.length; i++) {
            if (i < clipBoardText.length) {
              _controllers[i].text = clipBoardText[i];
            } else {
              _controllers[i].text = "";
            }
          }
        });
        int nextFocusIndex = clipBoardText.length < _controllers.length ? clipBoardText.length : _controllers.length - 1;
        _focusNodes[nextFocusIndex].requestFocus();
      }
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < 6; i++) {
      _focusNodes[i].dispose();
      _controllers[i].dispose();
    }
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(
                  'PIN Verification',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 1.h),
                Text(
                  'A 6 digit verification pin will send to your email Address',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                        (index) => SizedBox(
                      height: 50,
                      width: 50,
                      child: TextFormField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(counterText: ''),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: !pinVerificationInProgress,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.double_arrow_sharp, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInScreen()));
                      },
                      child: Text("Sign in", style: TextStyle(color: Colors.green)),
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
    verifyPin();
  }

  Future<void> verifyPin() async {
    String pin = _controllers.map((e) => e.text).join();

    if (pin.length != 6) {
      showSnackBarMessage(context, "Please enter a valid 6-digit pin");
      return;
    }

    setState(() {
      pinVerificationInProgress = true;
    });

    String pinUrl = Urls.recoverVerifyPinUrl + widget.email + "/" + pin;
    NetworkResponse response = await NetworkClient.getRequest(url: pinUrl);

    setState(() {
      pinVerificationInProgress = false;
    });

    if (response.isSuccess) {
      showSnackBarMessage(context, response.data!['data']);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email, otp: pin,)),
            (predicate) => false,
      );
    } else {
      showSnackBarMessage(context, response.data!['data']);
    }
  }
}
