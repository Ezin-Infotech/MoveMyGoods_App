import 'package:flutter/material.dart';

import 'app_bar.dart';

class CommonScaffold extends StatelessWidget {
  final Widget children;
  const CommonScaffold({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(375, 85), child: AppBarWidget()),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: children,
        ),
      ),
    );
  }
}
