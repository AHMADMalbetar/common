import 'package:flutter/material.dart';

class AppPageView extends StatelessWidget {
  AppPageView({
    super.key,
    required this.itemBuilder,
    this.pageController,
    this.onChange,
    required this.itemCount,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final Function(int)? onChange;
  final PageController? pageController;
  final int itemCount;

  final PageController defPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onChange,
      itemBuilder: itemBuilder,
      controller: pageController ?? defPageController,
      itemCount: itemCount,
    );
  }
}
