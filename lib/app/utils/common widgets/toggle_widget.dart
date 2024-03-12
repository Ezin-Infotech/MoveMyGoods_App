import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';

class MyToggleIconButton extends StatefulWidget {
  const MyToggleIconButton({super.key});

  @override
  _MyToggleIconButtonState createState() => _MyToggleIconButtonState();
}

class _MyToggleIconButtonState extends State<MyToggleIconButton> {
  bool isToggled = false; // Initial state

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isToggled
          ? Icon(Icons.radio_button_on, color: AppColors.primary)
          : const Icon(Icons.radio_button_off),
      onPressed: () {
        setState(() {
          isToggled = !isToggled;
        });
      },
    );
  }
}