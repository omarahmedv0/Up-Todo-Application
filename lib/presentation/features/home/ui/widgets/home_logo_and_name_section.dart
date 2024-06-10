// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:up_todo_app/app/app_prefs.dart';
import 'package:up_todo_app/app/extensions.dart';
import 'package:up_todo_app/app/injections.dart';
import 'package:up_todo_app/presentation/features/home/logic/home_cubit/home_cubit.dart';
import 'package:up_todo_app/presentation/features/home/logic/home_cubit/home_state.dart';
import 'package:up_todo_app/presentation/resources/assets_manager.dart';
import 'package:up_todo_app/presentation/resources/colors_manager.dart';
import 'package:up_todo_app/presentation/resources/styles_manager.dart';
import 'package:up_todo_app/presentation/routing/routes.dart';
import 'package:up_todo_app/presentation/shared/widgets/custom_dialog.dart';

// ignore: must_be_immutable
class HomeLogoAndNameSection extends StatelessWidget {
  HomeLogoAndNameSection({
    super.key,
  });

  AppPreferences appPreferences = getit.get();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is DeleteTheLocalDataBaseLoading) {
          showPopup(
            context,
            AnimationsAssets.loadingState,
            "loading..",
          );
        } else if (state is DeleteTheLocalDataBaseSuccess) {
          await appPreferences.preferences.clear();
          context.pop();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        }else if (state is DeleteTheLocalDataBaseError) {
          showPopup(
            context,
            AnimationsAssets.errorState,
            state.error,
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SVGsAssets.appLogo,
                color: ColorsManager.primary,
                width: 40.w,
                height: 40.h,
              ),
              Text(
                'UpToDo',
                style: TextStyles.font26BlueBold().copyWith(
                  letterSpacing: 2,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              await context.read<HomeCubit>().deleteTheLocalDataBase();
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
