import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';

class MyToggleIconButton extends StatelessWidget {
  final bool isToggled;
  final void Function() onPressed;
  const MyToggleIconButton(
      {super.key, required this.isToggled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isToggled
          ? Icon(Icons.radio_button_on, color: AppColors.primary)
          : const Icon(Icons.radio_button_off),
      onPressed: onPressed,
    );
  }
}

class MyToggleIconButtonFilter extends StatefulWidget {
  final bool isToggled;
  const MyToggleIconButtonFilter({super.key, required this.isToggled});

  @override
  _MyToggleIconButtonFilterState createState() =>
      _MyToggleIconButtonFilterState();
}

class _MyToggleIconButtonFilterState extends State<MyToggleIconButtonFilter> {
  @override
  Widget build(BuildContext context) {
    return widget.isToggled
        ? Icon(Icons.radio_button_on, color: AppColors.primary)
        : const Icon(Icons.radio_button_off);
  }
}
