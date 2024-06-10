import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/app_prefs.dart';
import '../../../../../app/extensions.dart';
import '../../../../../app/injections.dart';
import '../../../../../data/requests/requests.dart';
import '../../../../../domain/models/get_todos_model.dart';
import '../../logic/delete_todo/delete_todo_cubit.dart';
import '../../logic/delete_todo/delete_todo_state.dart';
import '../../logic/home_cubit/home_cubit.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../shared/helpers/spacing.dart';
import '../../../../shared/widgets/app_text_button.dart';
import '../../../../shared/widgets/custom_dialog.dart';

// ignore: must_be_immutable
class DeleteTodoBottomSheet extends StatelessWidget {
  DeleteTodoBottomSheet({
    super.key,
    required this.todoModel,
  });
  TodoModel todoModel;
  AppPreferences appPreferences = getit.get();
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteTodoCubit, DeleteTodoState>(
      listener: (context, state) {
        if (state is DeleteTodoStateError) {
          showPopup(
            context,
            AnimationsAssets.errorState,
            state.error,
            onButtonTap: () {
              context.pop();
            },
          );
        } else if (state is DeleteTodoStateSuccess) {
          context.read<HomeCubit>().getAllTodos(
                GetAllTodosRequest(
                  limit: 10,
                  skip: context.read<HomeCubit>().todosSkipped,
                  userId: appPreferences.getUserId(),
                ),
              );
          dismissDialog(context);
          context.pop();
        } else if (state is DeleteTodoStateLoading) {
          showPopup(
            context,
            AnimationsAssets.loadingState,
            "Loading",
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close, color: Colors.black),
                )
              ],
            ),
            verticalSpace(20),
            AppTextButton(
              buttonText: "Delete this todo?",
              textStyle: TextStyles.font16WhiteSemiBold(),
              onPressed: () {
                context.read<DeleteTodoCubit>().deleteTodo(
                      todoModel.id,
                    );
              },
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
