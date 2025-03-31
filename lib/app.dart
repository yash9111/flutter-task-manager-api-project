import 'package:flutter_task_manager_api_project/UI/screens/UserHomeScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'Data/model/task.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    List<Task> tasks = [
      Task('University', "after eid", "new"),
      Task('Mosque', "after migration", "Completed"),
      Task('Hajj', "after having descent amount of money", "Canceled"),
      Task('Charity', "51% of income inshaAllah", "Progress"),
    ];

    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          initialRoute: '/',
          routes: {
            '/home' : (context) => UserHomeScreen(tasks: tasks)
          },
          theme: ThemeData(textTheme: GoogleFonts.workSansTextTheme(textTheme),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.lightGreen)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.lightGreen)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.lightGreen)
            ),
            hintStyle: TextStyle(
              color: Colors.green.shade200,
            ),
            fillColor: Colors.white,
            filled: true
          ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(20)
              )
            )
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
