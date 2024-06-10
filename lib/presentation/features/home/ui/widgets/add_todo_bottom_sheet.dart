import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/app_prefs.dart';
import '../../../../../app/extensions.dart';
import '../../../../../app/injections.dart';
import '../../../../../data/requests/requests.dart';
import '../../logic/add_todo/add_todo_cubit.dart';
import '../../logic/add_todo/add_todo_state.dart';
import '../../logic/home_cubit/home_cubit.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../shared/helpers/spacing.dart';
import '../../../../shared/widgets/app_text_button.dart';
import '../../../../shared/widgets/custom_dialog.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  bool isCompleted = false;
  final AppPreferences _appPreferences = getit.get();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTodoCubit, AddTodoState>(
      listener: (context, state) async {
        if (state is AddTodoStateError) {
          dismissDialog(context);
          showPopup(
            context,
            AnimationsAssets.errorState,
            state.error,
            onButtonTap: () {
              context.pop();
            },
          );
        } else if (state is AddTodoStateSuccess) {
          dismissDialog(context);
          context.pop();
          await context.read<HomeCubit>().getAllTodos(
                GetAllTodosRequest(
                  limit: 10,
                  skip: context.read<HomeCubit>().todosSkipped,
                  userId: _appPreferences.getUserId(),
                ),
              );
        } else if (state is AddTodoStateLoading) {
          showPopup(
            context,
            AnimationsAssets.loadingState,
            "LoggingIn",
          );
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .8,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Form(
              key: context.read<AddTodoCubit>().formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .1,
                    child: TextFormField(
                      controller: context.read<AddTodoCubit>().textController,
                      selectionHeightStyle: BoxHeightStyle.tight,
                      expands: true,
                      maxLines: null,
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter todo content';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Add a todo',
                        hintStyle: TextStyles.getCaptionFont(context),
                        labelStyle: TextStyles.getCaptionFont(
                          context,
                          fontColor: Colors.black,
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: ColorsManager.primary,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          borderSide: BorderSide(
                            color: ColorsManager.gray.withOpacity(.4),
                          ),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCompleted = !isCompleted;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isCompleted
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          color: Colors.black,
                        ),
                        horizontalSpace(5),
                        Text(
                          "isCompeleted",
                          style: TextStyles.font16BlackSemiBold(),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(20),
                  AppTextButton(
                    buttonText: "Add Todo",
                    textStyle: TextStyles.font16WhiteSemiBold(),
                    onPressed: () {
                      if (context
                          .read<AddTodoCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                        context.read<AddTodoCubit>().addTodo(
                              /// todo id 255 is constant because the api will not add the todo in the server, its just simulate for testing.
                              /// so everytime the user will add a new todo it will be 255
                              AddTodoRequestBody(
                                completed: isCompleted,
                                todo: context
                                    .read<AddTodoCubit>()
                                    .textController
                                    .text,
                                userId: _appPreferences.getUserId(),
                                id: 255,
                              ),
                            );
                      }
                    },
                  ),
                  verticalSpace(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
