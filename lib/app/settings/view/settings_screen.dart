import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mmg/app/utils/common%20widgets/app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        appBar: PreferredSize(preferredSize: Size(375, 90), child: AppBarWidget()),
        body: Center(child: Text('Settings'),),),
    );
  }
}