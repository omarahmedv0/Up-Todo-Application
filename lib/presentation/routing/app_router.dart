import 'package:flutter/material.dart';
import '../../app/injections.dart';
import '../features/home/logic/update_todo/update_todo_cubit.dart';
import '../features/home/ui/screens/home_screen.dart';
import '../features/login/logic/login_cubit.dart';
import '../features/login/ui/screens/login_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import 'routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
Map<String, Widget Function(BuildContext)> appRouter = <String, WidgetBuilder>{
  Routes.onboarding: (c) => const OnboardingScreen(),
  Routes.login: (c) => BlocProvider(
        create: (context) => LoginCubit(getit.get(), getit.get()),
        child: const LoginScreen(),
      ),
  Routes.homeScreen: (c) => MultiBlocProvider(
        providers: [
          /* BlocProvider(
            create: (context) => HomeCubit(
              getit.get(),
              getit.get(),
              getit.get(),
            )..getAllTodos(
                GetAllTodosRequest(
                  limit: 10,
                  skip: context.read<HomeCubit>().todosSkipped,
                  userId: _appPreferences.getUserId(),
                ),
              ),
          ), */
          BlocProvider(
            create: (context) => UpdateTodoCubit(getit.get()),
          ),
        ],
        child:  HomeScreen(),
      ),
};
