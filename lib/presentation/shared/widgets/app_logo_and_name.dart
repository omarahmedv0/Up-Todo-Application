import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/styles_manager.dart';

class AppLogoAndName extends StatelessWidget {
  const AppLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SVGsAssets.appLogo,
          color: ColorsManager.primary,
          width: 80.w,
          height: 80.h,
        ),
        Text(
          'UpToDo',
          style: TextStyles.font26BlueBold().copyWith(
            letterSpacing: 2,
          ),
        )
      ],
    );
  }
}
