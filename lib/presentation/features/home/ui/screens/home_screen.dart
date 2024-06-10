import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/app_prefs.dart';
import '../../../../../app/injections.dart';
import '../../logic/home_cubit/home_cubit.dart';
import '../../logic/home_cubit/home_state.dart';
import '../widgets/todos_content_page.dart';
import '../widgets/home_floating_action_button_section.dart';
import '../widgets/home_logo_and_name_section.dart';

import '../../../../shared/helpers/spacing.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  AppPreferences appPreferences = getit.get();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        
        return SafeArea(
            child: Scaffold(
          floatingActionButton: const HomeFloatingActionButtonSection(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 15.h,
              ),
              child: Column(
                children: [
                  HomeLogoAndNameSection(),
                  verticalSpace(20),
                  TodosContentPage()
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
