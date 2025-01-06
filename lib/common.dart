library common;

import 'package:flutter/material.dart';

import 'common/util/helpers/init_async_main.dart';

class Common extends StatelessWidget {
  const Common({super.key, required this.main});

  final Widget main;

  @override
  Widget build(BuildContext context) {
    return Initialization.initLocalization(main);
  }
}
