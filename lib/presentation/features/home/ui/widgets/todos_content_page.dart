import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/app_prefs.dart';
import '../../../../../app/injections.dart';
import '../../../../../data/requests/requests.dart';
import '../../logic/home_cubit/home_cubit.dart';
import '../../logic/home_cubit/home_state.dart';
import 'todos_content_empty_state.dart';
import 'todos_content_state.dart';
import 'todos_page_loading_state.dart';
import '../../../../shared/widgets/full_screen_error_state.dart';

// ignore: must_be_immutable
class TodosContentPage extends StatelessWidget {
   TodosContentPage({
    super.key,
  });
AppPreferences appPreferences = getit.get();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetAllTodosSuccess) {
          if (context.read<HomeCubit>().doneTodos.isEmpty &&
              context.read<HomeCubit>().pendingTodos.isEmpty) {
            return const TodosContentEmptyState();
          } else {
            return  TodosContentState();
          }
        } else if (state is GetAllTodosError) {
          return FullScreenErrorState(
            message: state.error,
            onTap: () {
              context.read<HomeCubit>().getAllTodos(GetAllTodosRequest(
                limit: 10,
                skip: context.read<HomeCubit>().todosSkipped,
                userId: appPreferences.getUserId(),
              ),);
            },
          );
        } else if (state is GetAllTodosLoading) {
          return const TodosPageLoadingState();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
