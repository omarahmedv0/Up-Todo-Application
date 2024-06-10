import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/extensions.dart';
import 'widgets/onboarding_image_section.dart';
import 'widgets/onboarding_logo_section.dart';
import '../../resources/styles_manager.dart';
import '../../routing/routes.dart';
import '../../shared/helpers/spacing.dart';
import '../../shared/widgets/app_text_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoSection(),
              verticalSpace(50),
              const ImageSection(),
              verticalSpace(70),
              Text(
                "Manage your tasks",
                style: TextStyles.font32BlackBold(),
              ),
              verticalSpace(15),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You can easily manage all of your daily tasks in Up-ToDo for free',
                      textAlign: TextAlign.center,
                      style: TextStyles.font15GrayNormal(),
                    ),
                    verticalSpace(50),
                    AppTextButton(
                      buttonText: "Get Started",
                      textStyle: TextStyles.font16WhiteSemiBold(),
                      onPressed: () {
                        context.pushReplacementNamed(Routes.login);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
