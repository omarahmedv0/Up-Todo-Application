import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../resources/colors_manager.dart';
import '../../resources/styles_manager.dart';
import '../helpers/spacing.dart';

showPopup(BuildContext context, String imagePath, String message,
    {Function()? onButtonTap}) {
  dismissDialog(context);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => getPopUpDialog(
      context,
      imagePath,
      message,
      onButtonTap: onButtonTap,
    ),
  );
}

Widget getPopUpDialog(BuildContext context, String imagePath, String message,
    {Function()? onButtonTap}) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    elevation: 1.5,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.h,
              width: 70.w,
              child: Lottie.asset(
                imagePath,
              ),
            ),
            if (onButtonTap != null) verticalSpace(10),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Text(
                  message,
                  maxLines: 4,
                  style: TextStyles.getCaptionFont(
                    context,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.black.withOpacity(.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (onButtonTap != null) verticalSpace(10),
            if (onButtonTap != null)
              getRetryButton(
                context,
                onButtonTap,
                "Ok",
              ),
          ],
        ),
      ),
    ),
  );
}

_isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

Widget getRetryButton(
    BuildContext context, Function()? onTap, String buttonMessage) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 70,
    ),
    child: ElevatedButton(
      style: const ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          ColorsManager.primary,
        ),
      ),
      onPressed: onTap,
      child: Text(
        buttonMessage,
        style: TextStyles.getCaptionFont(
          context,
          fontColor: Colors.white,
        ),
      ),
    ),
  );
}
