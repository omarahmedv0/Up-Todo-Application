import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors_manager.dart';
import 'font_weight_helper.dart';

class TextStyles {
  static TextStyle font32BlackBold() {
    return TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle font36BlackW600() {
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle font26BlueBold() {
    return TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.bold,
      color: ColorsManager.primary,
    );
  }

  static TextStyle font24BlueBold() {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: ColorsManager.primary,
    );
  }

  static TextStyle font16WhiteSimeBold() {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  static TextStyle font15GrayNormal() {
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.normal,
      color: ColorsManager.gray,
    );
  }

  
  static TextStyle font20GrayW500() {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.gray,
    );
  }

  static TextStyle font14LightGrayRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: ColorsManager.lightGray,
  );
  static TextStyle font16WhiteSemiBold() => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: Colors.white,
      );

  static TextStyle font16BlackSemiBold() => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: Colors.black,
      );
  static TextStyle getCaptionFont(
    BuildContext context, {
    double fontSize = 16,
    Color fontColor = Colors.grey,
    double? height,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      color: fontColor,
      height: height,
      decoration: decoration,
      fontWeight: fontWeight,
      overflow: TextOverflow.ellipsis,
    );
  }
}
