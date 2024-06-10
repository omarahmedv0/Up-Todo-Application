import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/colors_manager.dart';

// ignore: must_be_immutable
class CustomShimmerBox extends StatelessWidget {
  CustomShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.isPadding = true,
    this.border = 10,
  });
  double width;
  double height;
  double border;

  bool isPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isPadding == true
            ? 20
            : 0,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: ColorsManager.lightGray.withOpacity(.3),
          highlightColor: ColorsManager.lightGray.withOpacity(.1),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(border),
            ),
          ),
        ),
      ),
    );
  }
}
