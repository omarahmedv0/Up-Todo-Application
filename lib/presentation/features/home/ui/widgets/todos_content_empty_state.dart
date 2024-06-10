
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../shared/helpers/spacing.dart';

class TodosContentEmptyState extends StatelessWidget {
  const TodosContentEmptyState({super.key});

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
          height: 150.h,
          width: 150.w,
          child: LottieBuilder.asset(
            AnimationsAssets.emptyState,
            fit: BoxFit.fill,
          ),
        ),
        verticalSpace(10),
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 1.5,
          child: Text(
            "No tasks found,\n create a new one to get started.",
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
      ],
    );
  }
}