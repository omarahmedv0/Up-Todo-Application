import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/home_cubit/home_cubit.dart';
import '../../logic/home_cubit/home_state.dart';
import 'custom_card_item.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../shared/helpers/spacing.dart';

class TodosContentState extends StatelessWidget {
   const TodosContentState({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CustomCardItem(
                todoModel: context.read<HomeCubit>().pendingTodos[index],
                isCompeleted: false,
              ),
              separatorBuilder: (context, index) => verticalSpace(5),
              itemCount: context.read<HomeCubit>().pendingTodos.length,
            ),
            verticalSpace(10),
            Text(
              'Completed Tasks',
              style: TextStyles.font16BlackSemiBold(),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CustomCardItem(
                todoModel: context.read<HomeCubit>().doneTodos[index],
                isCompeleted: true,
              ),
              separatorBuilder: (context, index) => verticalSpace(5),
              itemCount: context.read<HomeCubit>().doneTodos.length,
            ),
            verticalSpace(10),
            InkWell(
              onTap: () async {
                await context
                    .read<HomeCubit>()
                    .loadMoreTodos();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_downward, color: Colors.black),
                  horizontalSpace(5),
                  Text(
                    "Click to Load More Tasks",
                    style: TextStyles.font16BlackSemiBold(),
                  ),
                ],
              ),
            ),
            verticalSpace(20),
          ],
        );
      },
    );
  }
}
