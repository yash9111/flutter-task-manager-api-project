import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/set_password_screen.dart';
import 'package:flutter_task_manager_api_project/UI/widgets/backgroundSVG.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController(),);
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _pasteClipboard(i);
        }
      });
    }
  }

  Future<void> _pasteClipboard(int index) async {
    ClipboardData? clipboardData = await Clipboard.getData(
      Clipboard.kTextPlain,
    );
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
        int nextFocusIndex =
            clipBoardText.length < _controllers.length
                ? clipBoardText.length
                : _controllers.length - 1;
        _focusNodes[nextFocusIndex].requestFocus();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < 5; i++) {
      _focusNodes[i].dispose();
    }
    for (int i = 0; i < 5; i++) {
      _controllers[i].dispose();
    }
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
                      'PIN Verification',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'A 6 digit verification pin will send to your email Address',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    5,
                    (index) => SizedBox(
                      height: 50,
                      width: 60,
                      child: TextFormField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(counterText: ''),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 4) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetPasswordScreen()));
                    },
                    child: Icon(Icons.double_arrow_sharp, color: Colors.white),
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
