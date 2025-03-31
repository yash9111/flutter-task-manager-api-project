import 'package:flutter/material.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
    required this.args,
  });

  final Map args;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      toolbarHeight: 63,
      title: Row(
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
                args["data"],
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                args['email'],
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
