import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../resources/assets_manager.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      SVGsAssets.onboardingImage,
    );
  }
}
