// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';
import '../helpers/spacing.dart';
import 'custom_dialog.dart';

class FullScreenErrorState extends StatelessWidget {
  FullScreenErrorState({super.key, required this.message, required this.onTap});

  String message;
  dynamic Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 4,
        ),
        SizedBox(
          height: 70.h,
          width: 70.w,
          child: LottieBuilder.asset(
            AnimationsAssets.errorState,
            fit: BoxFit.fill,
          ),
        ),
        verticalSpace(20),
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 1.5,
          child: Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyles.getCaptionFont(
              context,
              fontSize: 15.sp,
              fontColor: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        verticalSpace(10),
        getRetryButton(
          context,
          onTap,
          "Retry",
        ),
      ],
    );
  }
}
