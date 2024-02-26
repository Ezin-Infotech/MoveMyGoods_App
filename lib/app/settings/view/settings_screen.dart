import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/utils/common%20widgets/app_bar.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      children: Consumer<SettingsProvider>(builder: (context, value, _) {
        return Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(value.settingsIcon[index]),
                    title: Text(value.settingsText[index]),
                    // trailing: index==0?ToggleButtons(children: children, isSelected: isSelected):,
                  );
                },
                separatorBuilder: (context, index) => const SizeBoxH(10),
                itemCount: value.settingsIcon.length)
          ],
        );
      }),
    );
  }
}
