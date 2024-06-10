import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/app_prefs.dart';
import '../../../../../app/extensions.dart';
import '../../../../../app/injections.dart';
import '../../../../../data/requests/requests.dart';
import '../../../../../domain/models/get_todos_model.dart';
import '../../logic/delete_todo/delete_todo_cubit.dart';
import '../../logic/home_cubit/home_cubit.dart';

import '../../logic/update_todo/update_todo_cubit.dart';

import '../../logic/update_todo/update_todo_state.dart';
import 'delete_todo_bottom_sheet.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../shared/helpers/spacing.dart';
import '../../../../shared/widgets/custom_dialog.dart';

// ignore: must_be_immutable
class CustomCardItem extends StatelessWidget {
  CustomCardItem({
    super.key,
    required this.todoModel,
    required this.isCompeleted,
  });
  TodoModel todoModel;
  bool isCompeleted;
AppPreferences appPreferences = getit.get();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTodoCubit, UpdateTodoState>(
      listener: (context, state) {
        if (state is UpdateTodoError) {
          showPopup(
            context,
            AnimationsAssets.errorState,
            state.error,
            onButtonTap: () {
              context.pop();
            },
          );
        } else if (state is UpdateTodoSuccess) {
          context.read<HomeCubit>().getAllTodos(GetAllTodosRequest(
                limit: 10,
                skip: context.read<HomeCubit>().todosSkipped,
                userId: appPreferences.getUserId(),
              ));
        }
      },
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => DeleteTodoCubit(getit.get()),
                      child: DeleteTodoBottomSheet(todoModel: todoModel),
                    );
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                surfaceTintColor: Colors.white.withOpacity(.3),
                color: isCompeleted == false
                    ? ColorsManager.lighterGray
                    : ColorsManager.lighterGray.withOpacity(.4),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await UpdateTodoCubit.get(context).editTodo(
                            UpdateTodoRequestBody(
                              id: todoModel.id,
                              completed: !todoModel.completed,
                            ),
                          );
                        },
                        child: Icon(
                          todoModel.completed
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: todoModel.completed
                              ? ColorsManager.primary
                              : Colors.black,
                        ),
                      ),
                      horizontalSpace(10),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1.4,
                        child: Text(
                          todoModel.todo,
                          style: TextStyles.font16BlackSemiBold(),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
