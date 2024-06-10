import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../data/requests/requests.dart';
import '../../logic/login_cubit.dart';
import '../widgets/login_bloc_listener.dart';
import '../widgets/user_name_and_password_section.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../shared/helpers/spacing.dart';
import '../../../../shared/widgets/app_logo_and_name.dart';
import '../../../../shared/widgets/app_text_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 30.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpace(20),
                const AppLogoAndName(),
                verticalSpace(70),
                Text(
                  "Welcome",
                  style: TextStyles.font36BlackW600().copyWith(
                    letterSpacing: 2,
                  ),
                ),
                verticalSpace(5),
                Text(
                  "        Login to your account",
                  maxLines: 3,
                  style: TextStyles.font20GrayW500(),
                ),
                verticalSpace(30),
                Column(
                  children: [
                    const UserNameAndPasswordSection(),
                    verticalSpace(40),
                    AppTextButton(
                      buttonText: "Login",
                      textStyle: TextStyles.font16WhiteSemiBold(),
                      onPressed: () {
                        if (context
                            .read<LoginCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<LoginCubit>().login(
                                LoginRequestBody(
                                  username: context
                                      .read<LoginCubit>()
                                      .usernameController
                                      .text,
                                  password: context
                                      .read<LoginCubit>()
                                      .passwordController
                                      .text,
                                ),
                              );
                        }
                      },
                    ),
                    const LoginBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
