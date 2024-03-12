import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleSwitchScreen extends StatelessWidget {
  final Function(int?)? onToggle;
  final bool isOn;
  const ToggleSwitchScreen({
    super.key,
    required this.isOn,
    this.onToggle,
  });
  //final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
        changeOnTap: false,
        minWidth: 18,
        minHeight: 18,
        cornerRadius: 20,
        borderWidth: 1,
        initialLabelIndex: isOn ? 1 : 0,
        borderColor: [isOn ? const Color(0xffC1AE97) : const Color(0xffC7C7CC)],
        activeFgColor: const Color(0xffC1AE97),
        activeBgColor: const [
          Colors.white
        ], // Set the background color when the switch is on
        inactiveBgColor: isOn
            ? const Color(0xffC1AE97)
            // ignore: dead_code
            : const Color(0xffC7C7CC),
        totalSwitches: 2,
        radiusStyle: true,
        onToggle: onToggle);
  }
}
