import 'package:flutter_task_manager_api_project/UI/screens/UserHomeScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'Data/model/task.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.green, onPrimary: Colors.green, secondary: Colors.green, onSecondary: Colors.white, error: Colors.red, onError: Colors.white, surface: Colors.white, onSurface: Colors.black),
            textTheme: GoogleFonts.workSansTextTheme(textTheme),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.lightGreen),
              ),
              hintStyle: TextStyle(color: Colors.green.shade200),
              fillColor: Colors.white,
              filled: true,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
