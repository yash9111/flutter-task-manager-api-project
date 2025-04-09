import 'package:flutter/material.dart';
import 'package:flutter_task_manager_api_project/UI/Controllers/auth_controller.dart';
import 'package:flutter_task_manager_api_project/UI/screens/UpdateProfileScreen.dart';
import 'package:flutter_task_manager_api_project/UI/screens/log_in_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromProfileScreen});

  final bool? fromProfileScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          if (fromProfileScreen ?? false){
            return;
          }else{
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
              child: Image.network(
                "https://avatars.githubusercontent.com/u/132939355?v=4",
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
            IconButton(onPressed: (){
              _onTapLogOutButton(context);
            }, icon: Icon(Icons.logout, color: Colors.white,),),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _onTapLogOutButton(BuildContext context) async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogInScreen()),
      (predicate) => false,
    );
  }

  void _onTapProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
  }
}
