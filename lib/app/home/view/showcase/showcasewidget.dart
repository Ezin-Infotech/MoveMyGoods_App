import 'package:flutter/material.dart';
import 'package:mmg/app/home/view/global_screen.dart';
import 'package:showcaseview/showcaseview.dart';

class MyShowCaseWidget extends StatelessWidget {
  const MyShowCaseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      enableShowcase: true,
      builder: Builder(
        builder: (context) => const GlobalScreen(),
      ),
    );
  }
}
