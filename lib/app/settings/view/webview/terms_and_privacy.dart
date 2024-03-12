import 'package:flutter/material.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndPrivacy extends StatefulWidget {
  final String url;
  const TermsAndPrivacy({super.key, required this.url});

  @override
  State<TermsAndPrivacy> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndPrivacy> {
  final WebViewController controller = WebViewController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final settingsProvider = context.read<SettingsProvider>();

      settingsProvider.init(controller, widget.url);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Consumer<SettingsProvider>(
          builder: (context, value, child) => Stack(
            children: [
              WebViewWidget(
                controller: controller,
              ),
              if (value.loadingPercentage < 100)
                LinearProgressIndicator(
                  value: value.loadingPercentage / 100.0,
                  color: const Color(0xFF333333),
                ),
            ],
          ),
        ));
  }
}
