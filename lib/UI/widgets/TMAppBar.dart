import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/auth_controller.dart';
import 'package:flutter_task_manager_api_project/UI/screens/UpdateProfileScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromProfileScreen});

  final bool? fromProfileScreen;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TMAppBar> createState() => _TMAppBarState();
}

class _TMAppBarState extends State<TMAppBar> {
  late bool isUpdated = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (widget.fromProfileScreen ?? false) {
            return;
          } else {
            _onTapProfileScreen(context);
          }
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/images/profile.jpg',
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fullName ?? "Unknown",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  AuthController.userModel?.email ?? "Unknown",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                _onTapLogOutButton(context);
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapLogOutButton(BuildContext context) async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogInScreen()),
      (predicate) => false,
    );
  }

  void _onTapProfileScreen(BuildContext context) async {
    isUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
    if (isUpdated) {
      setState(() {});
    }
  }
}
