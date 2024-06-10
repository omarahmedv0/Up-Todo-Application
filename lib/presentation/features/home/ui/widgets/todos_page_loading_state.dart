
import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../shared/helpers/spacing.dart';
import '../../../../shared/widgets/custom_shimmer_box.dart';

class TodosPageLoadingState extends StatelessWidget {
  const TodosPageLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => CustomShimmerBox(
        height: Random().nextInt(80).toDouble() + 20,
        width: double.infinity,
        isPadding: false,
        border: 8,
      ),
      separatorBuilder: (context, index) => verticalSpace(10),
      itemCount: 10,
    );
  }
}
