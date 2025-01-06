import 'package:common/common/extensions/font_extensions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppSmoothPageIndicator extends StatelessWidget {
  const AppSmoothPageIndicator({
    super.key,
    this.count,
    required this.controller,
  });

  final int? count;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      onDotClicked: (page){
        controller.jumpToPage(page);
      },
      controller: controller,
      count: count ?? 3,
      effect: ExpandingDotsEffect(
        dotColor: const Color(0xffC7C7CC),
        activeDotColor: context.primaryColor,
        dotWidth: 12,
        dotHeight: 12,
        expansionFactor: 2,
        spacing: 12
      ),
    );
  }
}
