import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_task_manager_api_project/UI/Utils/assetImagesUrl.dart';

class BackgroundSvg extends StatelessWidget {
  const BackgroundSvg({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetImages.backgroundImageSVG,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 20.h,
          bottom: 20.h,
          left: 10.w,
          right: 10.w,
          child: child ?? Center(child: Text("hello"),),
        ),
      ],
    );
  }
}
