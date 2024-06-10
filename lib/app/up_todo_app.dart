import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_prefs.dart';
import 'injections.dart';
import 'middleware.dart';
import '../data/requests/requests.dart';
import '../presentation/features/home/logic/home_cubit/home_cubit.dart';
import '../presentation/resources/app_theme_manager.dart';
import '../presentation/routing/app_router.dart';

// ignore: must_be_immutable
class UpTodoApp extends StatelessWidget {
  UpTodoApp({super.key});
  AppPreferences appPreferences = getit.get();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => HomeCubit(
          getit.get(),
          getit.get(),
          getit.get(),
        )..getAllTodos(
            GetAllTodosRequest(
              limit: 10,
              skip: 0,
              userId: appPreferences.getUserId(),
            ),
          ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemeManager.lightTheme(),
          initialRoute: initialScreenMiddleware(),
          routes: appRouter,
        ),
      ),
    );
  }
}
